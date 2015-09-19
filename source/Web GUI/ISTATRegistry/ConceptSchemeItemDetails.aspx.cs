﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using System.Globalization;
using System.Xml;
using System.IO;

using Org.Sdmxsource.Sdmx.Api.Model.Mutable.ConceptScheme;
using Org.Sdmxsource.Sdmx.Api.Model.Objects;
using Org.Sdmxsource.Sdmx.Api.Model.Objects.DataStructure;
using Org.Sdmxsource.Sdmx.Api.Model.Objects.ConceptScheme;
using Org.Sdmxsource.Sdmx.Api.Model.Objects.CategoryScheme;
using Org.Sdmxsource.Sdmx.SdmxObjects.Model.Mutable.ConceptScheme;
using Org.Sdmxsource.Sdmx.Api.Constants;
using Org.Sdmxsource.Sdmx.Util.Objects.Container;
using Org.Sdmxsource.Sdmx.SdmxObjects.Model.Mutable.Base;
using Org.Sdmxsource.Sdmx.Api.Model.Mutable.Base;

using ISTATUtils;
using ISTAT.EntityMapper;
using ISTAT.Entity;
using ISTAT.WSDAL;
using ISTATRegistry.MyService;

namespace ISTATRegistry
{

    public partial class conceptschemeItemDetails : ISTATRegistry.Classes.ISTATWebPage
    {

        public struct csvConcept
        {
            public string concept;
            public string name;
            public string description;
            public string parentConcept;

            public csvConcept(string concept, string name, string description, string parentConcept)
            {
                this.concept = concept;
                this.name = name;
                this.description = description;
                this.parentConcept = parentConcept;
            }
        }

        public static string KEY_PAGE_SESSION = "TempConceptscheme";

        ArtefactIdentity _artIdentity;
        Action _action;
        ISdmxObjects _sdmxObjects;
        LocalizedUtils _localizedUtils;
        protected string AspConfirmationExit = "false";

        private void SetAction()
        {
            if (Request["ACTION"] == null || Utils.ViewMode )
                _action = Action.VIEW;
            else
            {
                if ( Request["ACTION"] == "UPDATE" )
                {
                    MyService.User currentUser = Session[SESSION_KEYS.USER_DATA] as User;
                    _artIdentity = Utils.GetIdentityFromRequest(Request);
                    int agencyOccurence = currentUser.agencies.Count( agency => agency.id.Equals( _artIdentity.Agency) );
                    if ( agencyOccurence > 0 )
                    {
                        _action = (Action)Enum.Parse(typeof(Action), Request["ACTION"].ToString());
                    }
                    else
                    {
                        _action = Action.VIEW;
                    }
                }
                else
                {
                    _action = (Action)Enum.Parse(typeof(Action), Request["ACTION"].ToString());
                }
            }
        }

        private string GetAgencyValue()
        {
            if ( _action == Action.INSERT )
            {
                string agencyValue = cmbAgencies.SelectedValue.ToString();
                string agencyId = agencyValue.Split('-')[0].Trim();
                return agencyId;
            }
            else
            {
                return txtAgenciesReadOnly.Text;
            }
        }

        private IConceptSchemeMutableObject GetConceptschemeForm()
        {
            bool isInError = false;                 // Indicatore di errore
            string messagesGroup = string.Empty;    // Stringa di raggruppamento errori
            int errorCounter = 1;                   // Contatore errori

            #region CONCEPTSCHEME ID
            if (!ValidationUtils.CheckIdFormat(txtDSDID.Text))
            {
                messagesGroup += Convert.ToString(errorCounter) + ")" + Resources.Messages.err_id_format + "<br /><br />";
                errorCounter++;
                isInError = true;
            }
            #endregion

            #region CONCEPTSCHEME AGENCY
            if ( cmbAgencies.Text.Trim().Equals( string.Empty ) )
            {
                messagesGroup += Convert.ToString(errorCounter) + ") " + Resources.Messages.err_agency_missing + "<br /><br />";
                errorCounter++;
                isInError = true;
            }
            #endregion

            #region CONCEPTSCHEME VERSION
            if (!ValidationUtils.CheckVersionFormat(txtVersion.Text))
            {
                messagesGroup += Convert.ToString(errorCounter) + ")" + Resources.Messages.err_version_format + "<br /><br />";
                errorCounter++;
                isInError = true;
            }
            #endregion

            /* URI NOT REQUIRED */
            #region CONCEPTSCHEME URI
            if ((txtDSDURI.Text != string.Empty) && !ValidationUtils.CheckUriFormat(txtDSDURI.Text))
            {
                messagesGroup += Convert.ToString(errorCounter) + ")" + Resources.Messages.err_uri_format + "<br /><br />";
                errorCounter++;
                isInError = true;
            }
            #endregion

            #region CONCEPTSCHEME NAMES
            if (AddTextName.TextObjectList == null || AddTextName.TextObjectList.Count == 0)
            {
                messagesGroup += Convert.ToString(errorCounter) + ")" + Resources.Messages.err_list_name_format + "<br /><br />";
                errorCounter++;
                isInError = true;
            }
            #endregion

            #region CONCEPTSCHEME START END DATE
            bool checkForDatesCombination = true;

            if (!txtValidFrom.Text.Trim().Equals(string.Empty) && !ValidationUtils.CheckDateFormat(txtValidFrom.Text))
            {
                messagesGroup += Convert.ToString(errorCounter) + ")" + Resources.Messages.err_date_from_format + "<br /><br />";
                errorCounter++;
                checkForDatesCombination = false;
                isInError = true;
            }

            if (!txtValidTo.Text.Trim().Equals(string.Empty) && !ValidationUtils.CheckDateFormat(txtValidTo.Text))
            {
                messagesGroup += Convert.ToString(errorCounter) + ")" + Resources.Messages.err_date_to_format + "<br /><br />";
                errorCounter++;
                checkForDatesCombination = false;
                isInError = true;
            }

            if (!txtValidFrom.Text.Trim().Equals(string.Empty) && !txtValidTo.Text.Trim().Equals(string.Empty))
            {
                // Controllo congruenza date
                if (checkForDatesCombination)
                {
                    if (!ValidationUtils.CheckDates(txtValidFrom.Text, txtValidTo.Text))
                    {
                        messagesGroup += Convert.ToString(errorCounter) + ")" + Resources.Messages.err_date_diff + "<br /><br />";
                        errorCounter++;
                        isInError = true;
                    }
                }
            }
            #endregion

            if (isInError)
            {
                Utils.ShowDialog(messagesGroup, 300);
                return null;
            }

            IConceptSchemeMutableObject tmpConceptscheme = new ConceptSchemeMutableCore();
            #region CREATE CONCEPTSCHEME FROM FORM

            tmpConceptscheme.AgencyId = GetAgencyValue();
            tmpConceptscheme.Id = txtDSDID.Text;
            tmpConceptscheme.Version = txtVersion.Text;
            tmpConceptscheme.FinalStructure = TertiaryBool.ParseBoolean(chkIsFinal.Checked);
            tmpConceptscheme.Uri = (!txtDSDURI.Text.Trim().Equals( string.Empty ) && ValidationUtils.CheckUriFormat(txtDSDURI.Text)) ? new Uri(txtDSDURI.Text) : null;
            if (!txtValidFrom.Text.Trim().Equals(string.Empty))
            {
                tmpConceptscheme.StartDate = DateTime.ParseExact(txtValidFrom.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
            if (!txtValidTo.Text.Trim().Equals(string.Empty))
            {
                tmpConceptscheme.EndDate = DateTime.ParseExact(txtValidTo.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
            foreach (var tmpName in AddTextName.TextObjectList)
            {
                tmpConceptscheme.AddName(tmpName.Locale, tmpName.Value);
            }
            if (AddTextDescription.TextObjectList != null)
                foreach (var tmpDescription in AddTextDescription.TextObjectList)
                {
                    tmpConceptscheme.AddDescription(tmpDescription.Locale, tmpDescription.Value);
                }
            if (AnnotationGeneralControl.AnnotationObjectList != null)
                foreach (var annotation in AnnotationGeneralControl.AnnotationObjectList)
                {
                    tmpConceptscheme.AddAnnotation(annotation);
                }

            #endregion

            return tmpConceptscheme;
        }
        private IConceptSchemeMutableObject GetConceptschemeForm(IConceptSchemeMutableObject cs)
        {

            if (cs == null) return GetConceptschemeForm();

            bool isInError = false;                 // Indicatore di errore
            string messagesGroup = string.Empty;    // Stringa di raggruppamento errori
            int errorCounter = 1;                   // Contatore errori

            #region CONCEPTSCHEME ID
            if (!ValidationUtils.CheckIdFormat(txtDSDID.Text))
            {
                messagesGroup += Convert.ToString(errorCounter) + ")" + Resources.Messages.err_id_format + "<br /><br />";
                errorCounter++;
                isInError = true;
            }
            #endregion

            #region CONCEPTSCHEME AGENCY
            if ( cmbAgencies.Text.Trim().Equals( string.Empty ) )
            {
                messagesGroup += Convert.ToString(errorCounter) + ") " + Resources.Messages.err_agency_missing + "<br /><br />";
                errorCounter++;
                isInError = true;
            }
            #endregion

            #region CONCEPTSCHEME VERSION
            if (!ValidationUtils.CheckVersionFormat(txtVersion.Text))
            {
                messagesGroup += Convert.ToString(errorCounter) + ")" + Resources.Messages.err_version_format + "<br /><br />";
                errorCounter++;
                isInError = true;
            }
            #endregion
            
            /* URI NOT REQUIRED */
            #region CONCEPTSCHEME URI
            if ((txtDSDURI.Text != string.Empty) && !ValidationUtils.CheckUriFormat(txtDSDURI.Text))
            {
                messagesGroup += Convert.ToString(errorCounter) + ")" + Resources.Messages.err_uri_format + "<br /><br />";
                errorCounter++;
                isInError = true;
            }
            #endregion

            #region CONCEPTSCHEME NAMES
            if (AddTextName.TextObjectList == null || AddTextName.TextObjectList.Count == 0)
            {
                messagesGroup += Convert.ToString(errorCounter) + ")" + Resources.Messages.err_list_name_format + "<br /><br />";
                errorCounter++;
                isInError = true;
            }
            #endregion

            #region CONCEPTSCHEME START END DATE
            bool checkForDatesCombination = true;

            if (!txtValidFrom.Text.Trim().Equals(string.Empty) && !ValidationUtils.CheckDateFormat(txtValidFrom.Text))
            {
                messagesGroup += Convert.ToString(errorCounter) + ")" + Resources.Messages.err_date_from_format + "<br /><br />";
                errorCounter++;
                checkForDatesCombination = false;
                isInError = true;
            }

            if (!txtValidTo.Text.Trim().Equals(string.Empty) && !ValidationUtils.CheckDateFormat(txtValidTo.Text))
            {
                messagesGroup += Convert.ToString(errorCounter) + ")" + Resources.Messages.err_date_to_format + "<br /><br />";
                errorCounter++;
                checkForDatesCombination = false;
                isInError = true;
            }

            if (!txtValidFrom.Text.Trim().Equals(string.Empty) && !txtValidTo.Text.Trim().Equals(string.Empty))
            {
                // Controllo congruenza date
                if (checkForDatesCombination)
                {
                    if (!ValidationUtils.CheckDates(txtValidFrom.Text, txtValidTo.Text))
                    {
                        messagesGroup += Convert.ToString(errorCounter) + ")" + Resources.Messages.err_date_diff + "<br /><br />";
                        errorCounter++;
                        isInError = true;
                    }
                }
            }
            #endregion

            if (isInError)
            {
                Utils.ShowDialog(messagesGroup, 300);
                return null;
            }

            #region CREATE CONCEPTSCHEME FROM FORM   
            cs.AgencyId = GetAgencyValue();
            cs.Id = txtDSDID.Text;
            cs.Version = txtVersion.Text;
            cs.FinalStructure = TertiaryBool.ParseBoolean(chkIsFinal.Checked);
            cs.Uri = ( !txtDSDURI.Text.Trim().Equals( string.Empty ) && ValidationUtils.CheckUriFormat(txtDSDURI.Text)) ? new Uri(txtDSDURI.Text) : null;
            if (!txtValidFrom.Text.Trim().Equals(string.Empty))
            {
                cs.StartDate = DateTime.ParseExact(txtValidFrom.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
            if (!txtValidTo.Text.Trim().Equals(string.Empty))
            {
                cs.EndDate = DateTime.ParseExact(txtValidTo.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
            if (cs.Names.Count != 0)
            {
                cs.Names.Clear();
            }
            if (cs.Descriptions.Count != 0)
            {
                cs.Descriptions.Clear();
            }
            foreach (var tmpName in AddTextName.TextObjectList)
            {
                cs.AddName(tmpName.Locale, tmpName.Value);
            }
            if (AddTextDescription.TextObjectList != null)
                foreach (var tmpDescription in AddTextDescription.TextObjectList)
                {
                    cs.AddDescription(tmpDescription.Locale, tmpDescription.Value);
                }

            if (cs.Annotations.Count != 0)
            {
                cs.Annotations.Clear();
            }
            if (AnnotationGeneralControl.AnnotationObjectList != null)
                foreach (var annotation in AnnotationGeneralControl.AnnotationObjectList)
                {
                    cs.AddAnnotation(annotation);
                }

            #endregion

            return cs;
        }

        private IConceptSchemeMutableObject InsertConceptInConceptscheme(IConceptSchemeMutableObject cs)
        {
            if (cs == null) return null;

            IConceptMutableObject concept = new ConceptMutableCore();

            string concept_id = txt_id_new.Text.Trim();

            IList<ITextTypeWrapperMutableObject> concept_names = AddTextName_new.TextObjectList;
            IList<ITextTypeWrapperMutableObject> concept_descs = AddTextDescription_new.TextObjectList;
            string concept_parent_id = txt_parentid_new.Text.Trim();
            // string code_order_str = txtOrderNewCode.Text.Trim();     ----- ORDINE

            #region CONCEPT ID
            if (ValidationUtils.CheckIdFormat(concept_id))
            {
                concept.Id = concept_id;
            }
            else
            {
                lblErrorOnNewInsert.Text = Resources.Messages.err_id_format;
                Utils.AppendScript( "openPopUp('df-Dimension', 600);" );
                Utils.AppendScript("location.href= '#concepts';");
                return null;
            }

            IEnumerable<IConceptMutableObject> concepts = (from c in cs.Items where c.Id == concept_id select c).OfType<IConceptMutableObject>();
            if (concepts.Count() > 0)
            {
                lblErrorOnNewInsert.Text = Resources.Messages.err_id_exist;
                Utils.AppendScript( "openPopUp('df-Dimension', 600);" );
                Utils.AppendScript("location.href= '#concepts';");
                return null;
            }
            #endregion

            #region CODE NAMES
            if (concept_names != null)
            {
                foreach (var tmpName in concept_names)
                {
                    concept.AddName(tmpName.Locale, tmpName.Value);
                }
            }
            else
            {
                lblErrorOnNewInsert.Text = Resources.Messages.err_list_name_format;
                Utils.AppendScript( "openPopUp('df-Dimension', 600);" );
                Utils.AppendScript("location.href= '#concepts';");
                return null;
            }
            #endregion

            #region CONCEPT DESCRIPTIONS
            if (concept_descs != null)
            {
                foreach (var tmpDescription in concept_descs)
                {
                    concept.AddDescription(tmpDescription.Locale, tmpDescription.Value);
                }
            }
            #endregion

            #region PARANT ID

            if ( concept_id.Equals( concept_parent_id ) )
            {
                lblErrorOnNewInsert.Text = Resources.Messages.err_parent_id_same_value;
                Utils.AppendScript( "openPopUp('df-Dimension-update', 600 );" );
                Utils.AppendScript("location.href= '#concepts';");
                return null;
            }

            if (!concept_parent_id.Equals(string.Empty) && ValidationUtils.CheckIdFormat(concept_id))
            {
                IEnumerable<IConceptMutableObject> parentConcept = (from c in cs.Items where c.Id == concept_parent_id select c).OfType<IConceptMutableObject>();
                if (parentConcept.Count() > 0)
                    concept.ParentConcept = concept_parent_id;
                else
                {
                    lblErrorOnNewInsert.Text = Resources.Messages.err_parent_id_not_found;
                    Utils.AppendScript( "openPopUp('df-Dimension', 600);" );
                    Utils.AppendScript("location.href= '#concepts';");
                    return null;
                }
            }
            #endregion

            cs.Items.Add(concept);

            try
            {
                // Ultimo controllo se ottengo Immutable istanze validazione completa
                var canRead = cs.ImmutableInstance;
            }
            catch (Exception ex)
            {
                cs.Items.Remove(concept);

                return null;
            }

            return cs;
        }

        private IConceptSchemeMutableObject GetConceptSchemeFromSession()
        {
            try
            {
                if (Session[KEY_PAGE_SESSION] == null)
                {
                    if (_artIdentity.ToString() != string.Empty)
                    {
                        WSModel wsModel = new WSModel();
                        ISdmxObjects sdmxObject = wsModel.GetConceptScheme(_artIdentity, false,false);
                        IConceptSchemeObject cs = sdmxObject.ConceptSchemes.FirstOrDefault();
                        Session[KEY_PAGE_SESSION] = cs.MutableInstance;
                    }
                    else
                    {
                        throw new Exception();
                    }

                }
                return (IConceptSchemeMutableObject)Session[KEY_PAGE_SESSION];
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        private bool SaveInMemory(IConceptSchemeMutableObject cs)
        {
            if (cs == null) return false;

            Session[KEY_PAGE_SESSION] = cs;

            return true;
        }
        private bool SendQuerySubmit(IConceptSchemeMutableObject cs)
        {

            try
            {

                ISdmxObjects sdmxObjects = new SdmxObjectsImpl();

                sdmxObjects.AddConceptScheme(cs.ImmutableInstance);

                WSModel modelConceptScheme = new WSModel();

                XmlDocument result = modelConceptScheme.SubmitStructure(sdmxObjects);

                Utils.GetXMLResponseError(result);

                return true;

            }
            catch (Exception ex)
            {
                return false;
            }

        }
        private void ClearSessionPage()
        {
            Session[KEY_PAGE_SESSION] = null;
        }

        private int CurrentConceptIndex { get { return (int)Session[KEY_PAGE_SESSION + "_index_concept"]; } set { Session[KEY_PAGE_SESSION + "_index_concept"] = value; } }

        #region Event Handler

        protected void Page_Load(object sender, EventArgs e)
        {
            lblImportCsvTitle.DataBind();
            lblCsvLanguage.DataBind();
            lblcsvFile.DataBind();
            btnImportFromCsv.DataBind();
            lblDSDID.DataBind();
            lblVersion.DataBind();
            lblAgency.DataBind();
            lblValidFrom.DataBind();
            lblValidTo.DataBind();
            lblDSDURI.DataBind();
            lblDSDURN.DataBind();
            lblIsFinal.DataBind();
            lblDSDName.DataBind();
            lblDSDDescription.DataBind();
            lbl_title_new.DataBind();
            lbl_id_new.DataBind();
            lbl_name_new.DataBind();
            lbl_description_new.DataBind();
            lbl_parentid_new.DataBind();
            btnNewConcept.DataBind();
            lbl_title_update.DataBind();
            lbl_id_update.DataBind();
            lbl_name_update.DataBind();
            lbl_description_update.DataBind();
            lbl_parentid_update.DataBind();
            btnUpdateConcept.DataBind();
            btnAddNewConcept.DataBind();
            btnSaveMemoryConceptScheme.DataBind();
            btnSaveAnnotationCode.DataBind();
            lblNumberOfRows.DataBind();
            btnClearFields.DataBind();
            btnClearFieldForUpdate.DataBind();
            btnChangePaging.DataBind();
            lbl_annotation.DataBind();
            lblSeparator.DataBind();
            _localizedUtils = new LocalizedUtils(Utils.LocalizedCulture);

            SetAction();

            if (!IsPostBack)
            {
                Utils.PopulateCmbAgencies(cmbAgencies, true);
                ClearSessionPage();
                txtNumberOfRows.Text = Utils.DetailsConceptschemeGridNumberRow.ToString();
                AnnotationGeneralControl.ClearAnnotationsSession();
            }

            switch (_action)
            {
                case Action.INSERT:

                    //ClearSessionPage();

                    AspConfirmationExit = "true";

                    SetInitControls();
                    SetInsertForm();

                    lblNumberOfRows.Visible = false;
                    txtNumberOfRows.Visible = false;
                    btnChangePaging.Visible = false;

                    chkIsFinal.Checked = false;
                    chkIsFinal.Enabled = false;

                    AddTextName_Update.ucOpenTabName = "concepts";
                    AddTextName_Update.ucOpenPopUpWidth = 600;
                    AddTextName_Update.ucOpenPopUpName = "df-Dimension-update";

                    AddTextDescription_Update.ucOpenTabName = "concepts";
                    AddTextDescription_Update.ucOpenPopUpWidth = 600;
                    AddTextDescription_Update.ucOpenPopUpName = "df-Dimension-update";

                    AddTextName_new.ucOpenTabName = "concepts";
                    AddTextName_new.ucOpenPopUpWidth = 600;
                    AddTextName_new.ucOpenPopUpName = "df-Dimension";

                    AddTextDescription_new.ucOpenTabName = "concepts";
                    AddTextDescription_new.ucOpenPopUpWidth = 600;
                    AddTextDescription_new.ucOpenPopUpName = "df-Dimension";
                    if ( !Page.IsPostBack )
                    {
                        cmbAgencies.Items.Insert(0, new ListItem(String.Empty, String.Empty));
                        cmbAgencies.SelectedIndex = 0;
                        FileDownload31.Visible = false;
                    }
                    break;
                case Action.UPDATE:

                    _artIdentity = Utils.GetIdentityFromRequest(Request);
                    //ClearSessionPage();

                    SetInitControls();
                    SetEditForm();

                    AddTextName_Update.ucOpenTabName = "concepts";
                    AddTextName_Update.ucOpenPopUpWidth = 600;
                    AddTextName_Update.ucOpenPopUpName = "df-Dimension-update";

                    AddTextDescription_Update.ucOpenTabName = "concepts";
                    AddTextDescription_Update.ucOpenPopUpWidth = 600;
                    AddTextDescription_Update.ucOpenPopUpName = "df-Dimension-update";

                    AddTextName_new.ucOpenTabName = "concepts";
                    AddTextName_new.ucOpenPopUpWidth = 600;
                    AddTextName_new.ucOpenPopUpName = "df-Dimension";

                    AddTextDescription_new.ucOpenTabName = "concepts";
                    AddTextDescription_new.ucOpenPopUpWidth = 600;
                    AddTextDescription_new.ucOpenPopUpName = "df-Dimension";

                    /*if (gvConceptschemesItem.Rows.Count > 0)
                        chkIsFinal.Enabled = true;
                    else
                        chkIsFinal.Enabled = false;*/

                    break;
                case Action.VIEW:

                    _artIdentity = Utils.GetIdentityFromRequest(Request);
                    ClearSessionPage();
                    SetViewForm();

                    AddTextName_Update.ucOpenTabName = "concepts";
                    AddTextName_Update.ucOpenPopUpWidth = 600;
                    AddTextName_Update.ucOpenPopUpName = "df-Dimension-update";

                    AddTextDescription_Update.ucOpenTabName = "concepts";
                    AddTextDescription_Update.ucOpenPopUpWidth = 600;
                    AddTextDescription_Update.ucOpenPopUpName = "df-Dimension-update";

                    AddTextName_new.ucOpenTabName = "concepts";
                    AddTextName_new.ucOpenPopUpWidth = 600;
                    AddTextName_new.ucOpenPopUpName = "df-Dimension";

                    AddTextDescription_new.ucOpenTabName = "concepts";
                    AddTextDescription_new.ucOpenPopUpWidth = 600;
                    AddTextDescription_new.ucOpenPopUpName = "df-Dimension";
                    /*
                    FileDownload31.ucID = _artIdentity.ID;
                    FileDownload31.ucAgency = _artIdentity.Agency;
                    FileDownload31.ucVersion = _artIdentity.Version;
                    FileDownload31.ucArtefactType = "ConceptScheme";*/

                    break;
            }

            DuplicateArtefact1.ucStructureType = SdmxStructureEnumType.ConceptScheme;
            DuplicateArtefact1.ucMaintanableArtefact = GetConceptSchemeFromSession();
            if (_action == Action.INSERT)
                DuplicateArtefact1.Visible = false;

            lblNoItemsPresent.DataBind();

        }

        protected void gvConceptschemesItem_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvConceptschemesItem.PageSize = 12;
            gvConceptschemesItem.PageIndex = e.NewPageIndex;
            BindData();
            Utils.AppendScript("location.href= '#concepts';");
        }

        protected void btnSaveMemoryConceptScheme_Click(object sender, EventArgs e)
        {

            IConceptSchemeMutableObject cs = GetConceptSchemeFromSession();
            if (cs == null) cs = GetConceptschemeForm();
            else cs = GetConceptschemeForm(cs);

            if (!SaveInMemory(cs)) return;

            if (!SendQuerySubmit(cs)) return;

            BindData();

            string successMessage = string.Empty;
            if (((Action)Enum.Parse(typeof(Action), Request["ACTION"].ToString())) == Action.INSERT)
            {
                successMessage = Resources.Messages.succ_concept_insert;
            }
            else if (((Action)Enum.Parse(typeof(Action), Request["ACTION"].ToString())) == Action.UPDATE)
            {
                successMessage = Resources.Messages.succ_concept_update;
            }
            Utils.ShowDialog(successMessage, 300, Resources.Messages.succ_operation);
            if ( _action == Action.INSERT )
            {
                Utils.AppendScript( "~/conceptschemes.aspx" );
            }
        }

        protected void btnAddNewConcept_Click(object sender, EventArgs e)
        {

            IConceptSchemeMutableObject cs = GetConceptSchemeFromSession();

            cs = GetConceptschemeForm(cs);

            // form codelist validation
            if (cs == null)
            {
                txt_id_new.Text = string.Empty;
                txt_parentid_new.Text = string.Empty;
                AddTextName_new.ClearTextObjectListWithOutJS();
                AddTextDescription_new.ClearTextObjectListWithOutJS();
                lblErrorOnNewInsert.Text = string.Empty;
                return;
            }
            cs = InsertConceptInConceptscheme(cs);

            if (cs == null)
            {
                txt_id_new.Text = string.Empty;
                txt_parentid_new.Text = string.Empty;
                AddTextName_new.ClearTextObjectListWithOutJS();
                AddTextDescription_new.ClearTextObjectListWithOutJS();
                lblErrorOnNewInsert.Text = string.Empty;
                Utils.ShowDialog(Resources.Messages.err_concept_insert, 300, Resources.Messages.err_title);
                Utils.AppendScript("location.href= '#concepts';");
                return;
            }

            if (!SaveInMemory(cs))
            {
                txt_id_new.Text = string.Empty;
                txt_parentid_new.Text = string.Empty;
                AddTextName_new.ClearTextObjectListWithOutJS();
                AddTextDescription_new.ClearTextObjectListWithOutJS();
                lblErrorOnNewInsert.Text = string.Empty;
                return;
            }
            BindData();

            txt_id_new.Text = string.Empty;
            txt_parentid_new.Text = string.Empty;
            AddTextName_new.ClearTextObjectListWithOutJS();
            AddTextDescription_new.ClearTextObjectListWithOutJS();
            lblErrorOnNewInsert.Text = string.Empty;
            Utils.AppendScript("location.href='#concepts';");
        }

        protected void btnUpdateConcept_Click(object sender, EventArgs e)
        {

            // Get Input field
            string concept_id = txt_id_update.Text.Trim();
            IList<ITextTypeWrapperMutableObject> concept_names = AddTextName_Update.TextObjectList;
            IList<ITextTypeWrapperMutableObject> concept_descs = AddTextDescription_Update.TextObjectList;
            string concept_parent_id = txt_parentid_update.Text.Trim();
            // string code_order_str = txtUpdateCodeOrder.Text.Trim();
            
            // Get Current Object Session
            IConceptSchemeMutableObject cs = GetConceptSchemeFromSession();
            IEnumerable<IConceptMutableObject> _rc = (from x in cs.Items where x.Id == concept_id select x).OfType<IConceptMutableObject>();
            if (_rc.Count() == 0) return;

            IConceptMutableObject concept = _rc.First();

            IConceptMutableObject _bConcept = new ConceptMutableCore();

            int indexConcept = cs.Items.IndexOf(concept);
            int indexOrder = 0;
            try
            {

                #region CONCEPT ID
                if (!concept_id.Equals(string.Empty) && ValidationUtils.CheckIdFormat(concept_id))
                {
                    _bConcept.Id = concept_id;
                }
                else
                {
                    lblErrorOnUpdate.Text = Resources.Messages.err_id_format;
                    Utils.AppendScript( "openPopUp('df-Dimension-update', 600 );" );
                    Utils.AppendScript("location.href= '#concepts';");
                    return;
                }
                #endregion

                #region CONCEPT NAMES
                if (concept_names != null)
                {
                    foreach (var tmpName in concept_names)
                    {
                        _bConcept.AddName(tmpName.Locale, tmpName.Value);
                    }
                }
                else
                {
                    lblErrorOnUpdate.Text = Resources.Messages.err_list_name_format;
                    Utils.AppendScript( "openPopUp('df-Dimension-update', 600 );" );
                    Utils.AppendScript("location.href= '#concepts';");
                    return;
                }
                #endregion

                #region CONCEPT DESCRIPTIONS
                if (concept_descs != null)
                {
                    foreach (var tmpDescription in concept_descs)
                    {
                        _bConcept.AddDescription(tmpDescription.Locale, tmpDescription.Value);
                    }
                }
                #endregion

                #region PARANT ID

                if ( concept_id.Equals( concept_parent_id ) )
                {
                    lblErrorOnUpdate.Text = Resources.Messages.err_parent_id_same_value;
                    Utils.AppendScript( "openPopUp('df-Dimension-update', 600 );" );
                    Utils.AppendScript("location.href= '#concepts';");
                    return;
                }

                if (!concept_parent_id.Equals(string.Empty) && ValidationUtils.CheckIdFormat(concept_id))
                {
                    //IEnumerable<ICodeMutableObject> parentCode = (from c in cl.Items where c.Id == code_parent_id select c).OfType<ICodeMutableObject>();

                    IEnumerable<IConceptMutableObject> parentConcept = (from c in cs.Items where c.Id == concept_parent_id select c).OfType<IConceptMutableObject>();
                    if (parentConcept.Count() > 0)
                        _bConcept.ParentConcept = concept_parent_id;
                    else
                    {

                        lblErrorOnUpdate.Text = Resources.Messages.err_parent_id_not_found;
                        Utils.AppendScript( "openPopUp('df-Dimension-update', 600 );" );
                        Utils.AppendScript("location.href= '#concepts';");
                        return;
                    }
                }
                #endregion

                cs.Items.Remove(concept);
                cs.Items.Insert(indexConcept, _bConcept);

                var canRead = cs.ImmutableInstance;
            }
            catch (Exception ex) // ERRORE GENERICO!
            {
                cs.Items.Remove(_bConcept);
                cs.Items.Insert(indexConcept, concept);
                if ( ex.Message.Contains( "- 706 -" ) )
                {
                    lblErrorOnUpdate.Text = Resources.Messages.err_parent_item_is_child;
                    Utils.AppendScript( "openPopUp('df-Dimension-update', 600);" );
                 }
                else
                {
                    lblErrorOnUpdate.Text = Resources.Messages.err_concept_update;
                    Utils.AppendScript( "openPopUp('df-Dimension-update', 600);" );
                }
                Utils.AppendScript("location.href='#concepts';");
                return;
            }

            if (!SaveInMemory(cs))
                return;

            BindData();
            lblErrorOnUpdate.Text = string.Empty;
            Utils.AppendScript("location.href='#concepts';");
        }

        protected void gvConceptschemesItem_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "UPDATE":
                    {
                        // Svuoto i controlli
                        // ---------------------------------
                        txt_id_update.Text = string.Empty;
                        //txtUpdateCodeOrder.Text = string.Empty;
                        txt_parentid_update.Text = string.Empty;
                        AddTextName_Update.ClearTextObjectList();
                        AddTextDescription_Update.ClearTextObjectList();
                        // ---------------------------------

                        GridViewRow gvr = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);
                        txt_id_update.Text = ((Label)gvr.Cells[1].Controls[1]).Text;
                        txt_parentid_update.Text = ((Label)gvr.Cells[3].Controls[1]).Text;


                        IConceptSchemeMutableObject cs = GetConceptSchemeFromSession();

                        if (gvr.RowIndex < 0 && gvr.RowIndex > cs.ImmutableInstance.Items.Count) return;

                         if ( gvConceptschemesItem.PageIndex > 0 )
                        {
                            CurrentConceptIndex = gvr.RowIndex + ( gvConceptschemesItem.PageIndex * gvConceptschemesItem.PageSize );
                        }
                        else
                        {
                             CurrentConceptIndex = gvr.RowIndex;
                        }

                        IConceptObject currentConcept = ((IConceptObject)cs.ImmutableInstance.Items[CurrentConceptIndex]);

                        AddTextName_Update.ArtefactType = Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.Concept;
                        AddTextName_Update.TType = TextType.NAME;
                        AddTextName_Update.ClearTextObjectList();
                        AddTextName_Update.InitTextObjectList = currentConcept.Names;

                        AddTextDescription_Update.ArtefactType = Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.Concept;
                        AddTextDescription_Update.TType = TextType.DESCRIPTION;
                        AddTextDescription_Update.ClearTextObjectList();
                        AddTextDescription_Update.InitTextObjectList = currentConcept.Descriptions;
                        // txtUpdateCodeOrder.Text = (gvr.RowIndex + 1).ToString();
                        break;
                    }
                case "DELETE":
                    {

                        GridViewRow gvr = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);

                        IConceptSchemeMutableObject cs = GetConceptSchemeFromSession();

                        if (gvr.RowIndex < 0 && gvr.RowIndex > cs.Items.Count) return;

                        bool canDelete = true;
                        var parent_concept = cs.Items[gvr.RowIndex].Id;

                        #region PARANT ID
                        if (parent_concept != null)
                        {
                            IEnumerable<IConceptMutableObject> parentConcept = (from c in cs.Items where c.ParentConcept == parent_concept select c).OfType<IConceptMutableObject>();
                            if (parentConcept.Count() > 0)
                            {
                                Utils.ShowDialog(Resources.Messages.err_concept_is_parent, 300, Resources.Messages.err_title);
                                Utils.AppendScript("location.href= '#concepts';");

                                canDelete = false;
                            }
                        }
                        #endregion

                        if (canDelete)
                        {
                            cs.Items.RemoveAt(gvr.RowIndex);

                            Session[KEY_PAGE_SESSION] = cs;

                            BindData();
                        }

                        Utils.AppendScript("location.href='#concepts'");

                    }
                    break;
                case "ANNOTATION":
                    {
                        IConceptSchemeMutableObject cs = GetConceptSchemeFromSession();
                        cs = GetConceptschemeForm( cs );

                        GridViewRow gvr = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);
                     
                        if (gvr.RowIndex < 0 && gvr.RowIndex > cs.Items.Count) return;

                        if ( gvConceptschemesItem.PageIndex > 0 )
                        {
                            CurrentConceptIndex = gvr.RowIndex + ( gvConceptschemesItem.PageIndex * gvConceptschemesItem.PageSize );
                        }
                        else
                        {
                             CurrentConceptIndex = gvr.RowIndex;
                        }

                        //ctr_annotation_update.EditMode = !Utils.ViewMode;
                        btnSaveAnnotationCode.Visible = !Utils.ViewMode;

                        ctr_annotation_update.AnnotationObjectList = cs.Items[CurrentConceptIndex].Annotations;

                        Utils.AppendScript("openP('concept_annotation',650);");

                        Utils.AppendScript("location.href= '#concepts';");

                    } break;


            }

        }
        protected void gvConceptschemesItem_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // NULL
        }
        protected void gvConceptschemesItem_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // NULL
        }
        protected void gvConceptschemesItem_Sorting(object sender, GridViewSortEventArgs e)
        {

        }
        protected void gvCodelistsItem_Sorted(object sender, EventArgs e)
        {
            // NULL
        }
        protected void btnImportFromCsv_Click(object sender, EventArgs e)
        {
            if ( !csvFile.HasFile )
            {
                Utils.AppendScript( "openPopUp( 'importCsv' );" );
                Utils.AppendScript( "location.href='#concepts'" );
                Utils.AppendScript( string.Format( "alert( '{0}' );", Resources.Messages.err_no_file_uploaded ) );
                return;
            }

            IConceptSchemeMutableObject cs = GetConceptSchemeFromSession();

            if (cs == null) return;

            List<csvConcept> concepts = new List<csvConcept>();
            bool errorInUploading = false;
            StreamReader reader = null;
            StreamWriter logWriter = null;
            string wrongRowsMessage = string.Empty;
            string wrongRowsMessageForUser = string.Empty;
            string wrongFileLines = string.Empty;

            try
            {
                string filenameWithoutExtension = string.Format("{0}_{1}_{2}", Path.GetFileName(csvFile.FileName).Substring(0, csvFile.FileName.Length - 4), Session.SessionID, DateTime.Now.ToString().Replace('/', '_').Replace(':', '_').Replace(' ', '_'));
                string filename = string.Format("{0}.csv", filenameWithoutExtension);
                string logFilename = string.Format("{0}.log", filenameWithoutExtension);
                csvFile.SaveAs(Server.MapPath("~/csv_conceptschemes_files/") + filename);

                reader = new StreamReader(Server.MapPath("~/csv_conceptschemes_files/") + filename);
                logWriter = new StreamWriter(Server.MapPath("~/csv_conceptschemes_import_logs/") + logFilename, true);
                logWriter.WriteLine(string.Format("LOG RELATIVO A CARICAMENTO DEL CONCEPT SCHEME [ ID => \"{0}\"  AGENCY_ID => \"{1}\"  VERSION => \"{2}\" ]  |  LINGUA SELEZIONATA: {3}\n", cs.Id.ToString(), cs.AgencyId.ToString(), cs.Version.ToString(), cmbLanguageForCsv.SelectedValue.ToString()));
                logWriter.WriteLine("-----------------------------------------------------------------------------------------------------------------------------\n");
                reader.ReadLine();                
                int currentRow = 1;

                char separator = txtSeparator.Text.Trim().Equals( string.Empty ) ? ';' : txtSeparator.Text.Trim().ElementAt( 0 );

                while (!reader.EndOfStream)
                {
                    string  currentFileLine = reader.ReadLine();
                    string[] fields = currentFileLine.Split( separator );
                    if (fields.Length != 4)
                    {
                        errorInUploading = true;
                        wrongRowsMessage += string.Format(Resources.Messages.err_csv_import_line_bad_format, currentRow + 1);
                        wrongRowsMessageForUser += string.Format(Resources.Messages.err_csv_import_line_bad_format_gui, currentRow + 1);
                        wrongFileLines += string.Format( "{0}\n", currentFileLine );
                        logWriter.WriteLine(string.Format(Resources.Messages.err_csv_import_line_bad_format, currentRow + 1));
                        logWriter.Flush();
                        currentRow++;
                        continue;
                    }
                    if (fields[0].Trim().Equals("\"\"") || fields[0].Trim().Equals(string.Empty))
                    {
                        errorInUploading = true;
                        wrongRowsMessage += string.Format(Resources.Messages.err_csv_import_id_missing, currentRow + 1);
                        wrongRowsMessageForUser += string.Format(Resources.Messages.err_csv_import_id_missing_gui, currentRow + 1);
                        wrongFileLines += string.Format( "{0}\n", currentFileLine );
                        logWriter.WriteLine(string.Format(Resources.Messages.err_csv_import_id_missing, currentRow + 1));
                        logWriter.Flush();
                        currentRow++;
                        continue;
                    }
                    if (fields[1].Trim().Equals("\"\"") || fields[1].Trim().Equals(string.Empty))
                    {
                        errorInUploading = true;
                        wrongRowsMessage += string.Format(Resources.Messages.err_csv_import_name_missing, currentRow + 1);
                        wrongRowsMessageForUser += string.Format(Resources.Messages.err_csv_import_name_missing_gui, currentRow + 1);
                        wrongFileLines += string.Format( "{0}\n", currentFileLine );
                        logWriter.WriteLine(string.Format(Resources.Messages.err_csv_import_name_missing, currentRow + 1));
                        logWriter.Flush();
                        currentRow++;
                        continue;
                    }
                    concepts.Add(new csvConcept(fields[0].ToString().Replace("\"", ""), fields[1].ToString().Replace("\"", ""), fields[2].ToString().Replace("\"", ""), fields[3].ToString().Replace("\"", "")));
                    currentRow++;
                }
            }
            catch (Exception ex)
            {
                Utils.AppendScript(string.Format("Upload status: The file could not be uploaded. The following error occured: {0}", ex.Message));
            }

            foreach (csvConcept concept in concepts)
            {

                if ( !concept.parentConcept.Trim().Equals( string.Empty ) )
                {
                    int cont = (from myConcept in cs.Items 
                                where myConcept.Id.Equals( concept.parentConcept )
                                select myConcept).Count();
                    if ( cont == 0 )
                    {
                        errorInUploading = true;
                        wrongRowsMessageForUser += string.Format(Resources.Messages.err_csv_import_parent_code_error, concept.parentConcept, concept.concept, concept.concept );     
                        continue;
                    }
                }

                IEnumerable<IConceptMutableObject> tmpConcepts = (from conc in cs.Items where conc.Id == concept.concept select conc).OfType<IConceptMutableObject>();

                IConceptMutableObject tmpConcept;

                if (!(tmpConcepts.Count() > 0))
                {
                    tmpConcept = new ConceptMutableCore();
                    tmpConcept.Id = concept.concept;
                    tmpConcept.ParentConcept = concept.parentConcept;
                    tmpConcept.AddName(cmbLanguageForCsv.SelectedValue.ToString(), concept.name);
                    tmpConcept.AddDescription(cmbLanguageForCsv.SelectedValue.ToString(), concept.description);
                    cs.AddItem(tmpConcept);
                }
                else
                {
                    tmpConcept = tmpConcepts.First();
                    tmpConcept.Id = concept.concept;
                    tmpConcept.ParentConcept = concept.parentConcept;
                    tmpConcept.AddName(cmbLanguageForCsv.SelectedValue.ToString(), concept.name);
                    tmpConcept.AddDescription(cmbLanguageForCsv.SelectedValue.ToString(), concept.description);
                }
            }

            if ( errorInUploading )   
            {
                lblImportCsvErrors.Text = wrongRowsMessageForUser;
                lblImportCsvWrongLines.Text = wrongFileLines;
                Utils.AppendScript("openP('importCsvErrors',500);");
            }

            logWriter.Close();
            reader.Close();

            if (!SaveInMemory(cs))
                return;

            BindData();
            if ( !errorInUploading )
            {
                Utils.ShowDialog( Resources.Messages.succ_operation );
            }
            Utils.AppendScript("location.href='#concepts';");

        }

        #endregion

        #region LAYOUT

        private void SetLabelDetail()
        {

            IConceptSchemeMutableObject cs = GetConceptSchemeFromSession();

            if (cs == null)
                lblConceptSchemeDetail.Text = String.Format("({0}+{1}+{2})", _artIdentity.ID, _artIdentity.Agency, _artIdentity.Version);
            else
            {

                lblConceptSchemeDetail.Text = String.Format("{3} ({0}+{1}+{2})", _artIdentity.ID, _artIdentity.Agency, _artIdentity.Version, _localizedUtils.GetNameableName(cs.ImmutableInstance));
            }
        }
        private void BindData(bool isNewItem = false)
        {
            IConceptSchemeMutableObject cs = GetConceptSchemeFromSession();

            if (cs == null) return;

            SetGeneralTab(cs.ImmutableInstance);

            LocalizedUtils localUtils = new LocalizedUtils(Utils.LocalizedCulture);
            EntityMapper eMapper = new EntityMapper(Utils.LocalizedLanguage);
            IList<Concept> lConceptSchemeItem = new List<Concept>();

            foreach (IConceptObject concept in cs.ImmutableInstance.Items)
            {
                lConceptSchemeItem.Add(new Concept(concept.Id, localUtils.GetNameableName(concept), localUtils.GetNameableDescription(concept), concept.ParentConcept));
            }
            
            int numberOfRows = 0;

            if ( !txtNumberOfRows.Text.Trim().Equals( string.Empty ) && int.TryParse( txtNumberOfRows.Text, out numberOfRows ) )
            {
                gvConceptschemesItem.PageSize = numberOfRows;
            }
            else
            {
                gvConceptschemesItem.PageSize = Utils.DetailsConceptschemeGridNumberRow;
            }
            lblNumberOfTotalElements.Text = string.Format( Resources.Messages.lbl_number_of_total_rows, lConceptSchemeItem.Count.ToString() );
            gvConceptschemesItem.DataSource = lConceptSchemeItem;
            gvConceptschemesItem.DataBind();

            if ( lConceptSchemeItem.Count == 0 )
            {
                txtNumberOfRows.Visible = false;
                lblNumberOfRows.Visible = false;
                btnChangePaging.Visible = false;
                lblNoItemsPresent.Visible = true;
                lblNumberOfTotalElements.Visible = false;
            }
            else
            {
                txtNumberOfRows.Visible = true;
                lblNumberOfRows.Visible = true;
                btnChangePaging.Visible = true;
                lblNoItemsPresent.Visible = false;
                lblNumberOfTotalElements.Visible = true;
            }
        }

        private void SetGeneralTab(IConceptSchemeObject cs)
        {
            txtDSDID.Text = cs.Id;
            txtAgenciesReadOnly.Text = cs.AgencyId;
            txtVersion.Text = cs.Version;
            chkIsFinal.Checked = cs.IsFinal.IsTrue;

            FileDownload31.ucID = cs.Id;
            FileDownload31.ucAgency = cs.AgencyId;
            FileDownload31.ucVersion = cs.Version;
            FileDownload31.ucArtefactType = "ConceptScheme";

            txtDSDURI.Text = (cs.Uri != null) ? cs.Uri.AbsoluteUri : string.Empty;
            txtDSDURN.Text = (cs.Urn != null) ? cs.Urn.AbsoluteUri : string.Empty;
            txtValidFrom.Text = (cs.StartDate != null) ? string.Format("{0}/{1}/{2}", cs.StartDate.Date.Value.Day.ToString(), cs.StartDate.Date.Value.Month.ToString(), cs.StartDate.Date.Value.Year.ToString()) : string.Empty;
            txtValidTo.Text = (cs.EndDate != null) ? string.Format("{0}/{1}/{2}", cs.EndDate.Date.Value.Day.ToString(), cs.EndDate.Date.Value.Month.ToString(), cs.EndDate.Date.Value.Year.ToString()) : string.Empty;
            txtDSDName.Text = _localizedUtils.GetNameableName(cs);
            txtDSDDescription.Text = _localizedUtils.GetNameableDescription(cs);

            // Svuoto le griglie name e description
            //===========================================
            if (AddTextName.TextObjectList != null && AddTextName.TextObjectList.Count != 0)
            {
                AddTextName.ClearTextObjectList();
            }
            if (AddTextDescription.TextObjectList != null && AddTextDescription.TextObjectList.Count != 0)
            {
                AddTextDescription.ClearTextObjectList();
            }

            txtDSDID.Enabled = false;
            txtVersion.Enabled = false;
            cmbAgencies.Enabled = false;

            if (_action == Action.VIEW || cs.IsFinal.IsTrue)
            {
                AddTextName.Visible = false;
                AddTextDescription.Visible = false;
                txtAllDescriptions.Visible = true;
                txtAllNames.Visible = true;
                chkIsFinal.Enabled = false;
                txtAllDescriptions.Text = _localizedUtils.GetNameableDescription(cs);
                txtAllNames.Text = _localizedUtils.GetNameableName(cs);
            }
            else
            {
                AspConfirmationExit = "true";

                AddTextName.Visible = true;
                AddTextDescription.Visible = true;
                txtAllDescriptions.Visible = false;
                txtAllNames.Visible = false;

                /*
                 * DA IMPLEMENTARE L'ADDING NELLE GRIDS DI MASSIMILIANO 
                 */

                AddTextName.InitTextObjectList = cs.Names;
                AddTextDescription.InitTextObjectList = cs.Descriptions;
            }

            if ( _action != Action.VIEW )
            {
                DuplicateArtefact1.Visible = true;
            }

            AnnotationGeneralControl.AddText_ucOpenTabName = AnnotationGeneralControl.ClientID;
            AnnotationGeneralControl.AnnotationObjectList = cs.MutableInstance.Annotations;
            AnnotationGeneralControl.EditMode = (cs.IsFinal.IsTrue || _action == Action.VIEW) ? false : true;
            AnnotationGeneralControl.OwnerAgency =  txtAgenciesReadOnly.Text;
            ctr_annotation_update.EditMode = (cs.IsFinal.IsTrue || _action == Action.VIEW) ? false : true;

            if (cs.IsFinal.IsTrue || _action == Action.VIEW)
            {
                txtValidFrom.Enabled = false;
                txtValidTo.Enabled = false;
                txtDSDName.Enabled = false;
                txtDSDDescription.Enabled = false;
                txtDSDURI.Enabled = false;
                chkIsFinal.Enabled = false;
            }
            else
            {
                txtValidFrom.Enabled = true;
                txtValidTo.Enabled = true;
                txtDSDName.Enabled = true;
                txtDSDDescription.Enabled = true;
                txtDSDURI.Enabled = true;
                chkIsFinal.Enabled = true;
            }

            //===========================================
            if ( _action == Action.INSERT )
            {
                cmbAgencies.Visible = true;
                txtAgenciesReadOnly.Visible = false;
            }
            else
            {
                cmbAgencies.Visible = false;
                txtAgenciesReadOnly.Visible = true;
            }

            SetCodeDetailPanel(cs);
        }
        private void SetCodeDetailPanel(IConceptSchemeObject cs)
        {
            // Verifico se la codelist è final
            if (cs.IsFinal.IsTrue || _action == Action.VIEW)
            {
                // Se final il pulsante di add e le colonne di modifica
                // dei codici non devono apparire
                btnSaveMemoryConceptScheme.Visible = false;
                btnAddNewConcept.Visible = false;
                AddTextName_Update.ucEditMode = false;
                AddTextDescription_Update.ucEditMode = false;
                txt_parentid_update.Enabled = false;
                AnnotationGeneralControl.EditMode = false;
                btnSaveAnnotationCode.Enabled = false;
                btnUpdateConcept.Enabled = false;
                //gvConceptschemesItem.Columns[3].Visible = false;
                //gvConceptschemesItem.Columns[4].Visible = false;
                gvConceptschemesItem.Columns[5].Visible = false;
                cmbLanguageForCsv.Visible = false;
                imgImportCsv.Visible = false;
            }
            else
            {
                btnSaveMemoryConceptScheme.Visible = true;
                btnAddNewConcept.Visible = true;
                gvConceptschemesItem.Columns[3].Visible = true;
                gvConceptschemesItem.Columns[4].Visible = true;
                gvConceptschemesItem.Columns[5].Visible = true;
                Utils.PopulateCmbLanguages(cmbLanguageForCsv, AVAILABLE_MODES.MODE_FOR_ADD_TEXT);
                cmbLanguageForCsv.Visible = true;
                imgImportCsv.Visible = true;
            }
        }
        private void SetInsertForm()
        {
            SetEditingControl();
        }
        private void SetEditForm()
        {
            if (!IsPostBack)
            {
                SetLabelDetail();
                btnSaveMemoryConceptScheme.Visible = true;
                SetEditingControl();
                BindData(true);
                SetSDMXObjects();
            }
            GetSDMXObjects();
        }
        private void SetViewForm()
        {
            if (!Page.IsPostBack)
            {
                SetLabelDetail();
                BindData();
                btnSaveMemoryConceptScheme.Visible = false;
            }
        }
        private void SetEditingControl()
        {
            txtDSDID.Enabled = true;
            txtVersion.Enabled = true;
            txtDSDURI.Enabled = true;
            txtValidFrom.Enabled = true;
            txtValidTo.Enabled = true;
            txtDSDName.Enabled = true;
            txtDSDDescription.Enabled = true;
            cmbAgencies.Enabled = true;
            chkIsFinal.Enabled = true;
            pnlEditName.Visible = true;
            pnlEditDescription.Visible = true;
            btnSaveMemoryConceptScheme.Visible = true;

            // Svuoto le griglie di name e description
            if (Request["ACTION"] == "INSERT" && !Page.IsPostBack)
            {
                AddTextName.ClearTextObjectList();
                AddTextDescription.ClearTextObjectList();
            }
        }
        private void SetInitControls()
        {
            AddTextName.ArtefactType = Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.ConceptScheme;
            AddTextName.TType = TextType.NAME;

            AddTextDescription.ArtefactType = Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.ConceptScheme;
            AddTextDescription.TType = TextType.DESCRIPTION;

            AddTextName_new.TType = TextType.NAME;
            AddTextDescription_new.TType = TextType.DESCRIPTION;

            AddTextName_Update.TType = TextType.NAME;
            AddTextDescription_Update.TType = TextType.DESCRIPTION;
        }
        private void GetSDMXObjects()
        {
            _sdmxObjects = (ISdmxObjects)Session["SDMXObjexts"];
        }
        private void SetSDMXObjects()
        {
            Session["SDMXObjexts"] = _sdmxObjects;
        }
        #endregion

        protected void btnSaveAnnotationConcept_Click(object sender, EventArgs e)
        {
            IConceptSchemeMutableObject cs = GetConceptSchemeFromSession();

            if (!SaveInMemory(cs)) return;

            BindData();

            Utils.AppendScript("location.href='#concepts';");
        }

        protected void txtNumberOfRows_TextChanged(object sender, EventArgs e)
        {
        }

        protected void btnClearFields_Click(object sender, EventArgs e)
        {
            txt_id_new.Text = string.Empty;
            AddTextName_new.ClearTextObjectListWithOutJS();
            AddTextDescription_new.ClearTextObjectListWithOutJS();
            txt_parentid_new.Text = string.Empty;
            lblErrorOnNewInsert.Text = string.Empty;
            Utils.AppendScript("location.href= '#concepts';");
        }

        protected void btnClearFieldsForUpdate_Click(object sender, EventArgs e)
        {
            lblErrorOnUpdate.Text = string.Empty;
            Utils.AppendScript("location.href= '#concepts';");
        }

        protected void btnChangePaging_Click(object sender, EventArgs e)
        {
              IConceptSchemeMutableObject cs = GetConceptSchemeFromSession();

            if (cs == null) return;

            EntityMapper eMapper = new EntityMapper(Utils.LocalizedLanguage);
            List<ISTAT.Entity.ConceptScheme> lConceptscheme = eMapper.GetConceptSchemeList(_sdmxObjects);
            IList<Concept> lConceptSchemeItem = new List<Concept>();

            foreach (IConceptObject concept in cs.ImmutableInstance.Items)
            {
                lConceptSchemeItem.Add(new Concept(concept.Id, _localizedUtils.GetNameableName(concept), _localizedUtils.GetNameableDescription(concept), concept.ParentConcept));
            }

            int numberOfRows = 0;

            if ( !txtNumberOfRows.Text.Trim().Equals( string.Empty ) && int.TryParse( txtNumberOfRows.Text, out numberOfRows ) )
            {
                if ( numberOfRows > 0 )
                {
                    gvConceptschemesItem.PageSize = numberOfRows;
                }
                else
                {
                    gvConceptschemesItem.PageSize = Utils.DetailsConceptschemeGridNumberRow;
                    txtNumberOfRows.Text = Utils.DetailsConceptschemeGridNumberRow.ToString();
                }
            }
            else if ( !txtNumberOfRows.Text.Trim().Equals( string.Empty ) && !int.TryParse( txtNumberOfRows.Text, out numberOfRows ) )
            {
                Utils.ShowDialog( Resources.Messages.err_wrong_rows_number_pagination );
                Utils.AppendScript( "location.href='#concepts';" );
                return;
            }
            else if ( txtNumberOfRows.Text.Trim().Equals( string.Empty ) )
            {
                gvConceptschemesItem.PageSize = Utils.DetailsConceptschemeGridNumberRow;
                txtNumberOfRows.Text = Utils.DetailsConceptschemeGridNumberRow.ToString();
            }
            gvConceptschemesItem.DataSource = lConceptSchemeItem;
            gvConceptschemesItem.DataBind();     
            Utils.AppendScript( "location.href='#concepts';" );
        }

        protected void gvConceptschemesItem_RowDataBound(object sender, GridViewRowEventArgs e)
        {
           IConceptSchemeMutableObject cs = GetConceptSchemeFromSession();
           if ( e.Row.RowIndex != -1 )
           {
               string conceptId = ((Label)e.Row.Cells[1].Controls[1]).Text;
               IConceptMutableObject concept = cs.Items.Where( c => c.Id.ToString().Equals( conceptId ) ).First();
               Label lblNumber = (Label)e.Row.Cells[6].Controls[1];
               ImageButton btnImage = (ImageButton)e.Row.Cells[6].Controls[3];
               int numberOfAnnotation = concept.Annotations.Count;
               lblNumber.Text = numberOfAnnotation.ToString();
               if ( numberOfAnnotation == 0 && ( cs.FinalStructure.IsTrue || _action == Action.VIEW ) )
               {
                   btnImage.Enabled = false;
               }
           }
        }

    }

}