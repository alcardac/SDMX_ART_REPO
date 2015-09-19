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
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;

using Org.Sdmxsource.Sdmx.Api.Model.Mutable.Codelist;
using Org.Sdmxsource.Sdmx.Api.Model.Objects;
using Org.Sdmxsource.Sdmx.Api.Model.Objects.DataStructure;
using Org.Sdmxsource.Sdmx.Api.Model.Objects.Codelist;
using Org.Sdmxsource.Sdmx.Api.Model.Objects.CategoryScheme;
using Org.Sdmxsource.Sdmx.SdmxObjects.Model.Mutable.Codelist;
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

    public partial class codelistItemDetails : ISTATRegistry.Classes.ISTATWebPage
    {

        public struct csvCode
        {
            public string code;
            public string name;
            public string description;
            public string parentCode;

            public csvCode(string code, string name, string description, string parentCode)
            {
                this.code = code;
                this.name = name;
                this.description = description;
                this.parentCode = parentCode;
            }
        }

        public static string KEY_PAGE_SESSION = "TempCodelist";

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
                string agencyValue = cmb_agencies.SelectedValue.ToString();
                string agencyId = agencyValue.Split('-')[0].Trim();
                return agencyId;
            }
            else
            {
                return txtAgenciesReadOnly.Text;
            }
        }

        private ICodelistMutableObject GetCodelistForm()
        {
            bool isInError = false;                 // Indicatore di errore
            string messagesGroup = string.Empty;    // Stringa di raggruppamento errori
            int errorCounter = 1;                   // Contatore errori

            #region CODELIST ID
            if (!ValidationUtils.CheckIdFormat(txt_id.Text.Trim()))
            {
                messagesGroup += Convert.ToString(errorCounter) + ") "+Resources.Messages.err_id_format+"<br /><br />";
                errorCounter++;
                isInError = true;
            }
            #endregion

            #region CODELIST AGENCY
            if ( cmb_agencies.Text.Trim().Equals( string.Empty ) )
            {
                messagesGroup += Convert.ToString(errorCounter) + ") " + Resources.Messages.err_agency_missing + "<br /><br />";
                errorCounter++;
                isInError = true;
            }
            #endregion

            #region CODELIST VERSION
            if (!ValidationUtils.CheckVersionFormat(txt_version.Text.Trim()))
            {
                messagesGroup += Convert.ToString(errorCounter) + ") " + Resources.Messages.err_version_format + "<br /><br />";
                errorCounter++;
                isInError = true;
            }
            #endregion

            /* URI NOT REQUIRED */
            #region CODELLIST URI
            if ((txt_uri.Text != string.Empty) && !ValidationUtils.CheckUriFormat(txt_uri.Text))
            {
                messagesGroup += Convert.ToString(errorCounter) + ") " + Resources.Messages.err_uri_format + "<br /><br />";
                errorCounter++;
                isInError = true;
            }
            #endregion

            #region CODELIST NAMES
            if (AddTextName.TextObjectList == null || AddTextName.TextObjectList.Count == 0)
            {
                messagesGroup += Convert.ToString(errorCounter) + ") " + Resources.Messages.err_list_name_format + "<br /><br />";
                errorCounter++;
                isInError = true;
            }
            #endregion

            #region CODELIST START END DATE
            bool checkForDatesCombination = true;

            if (!txt_valid_from.Text.Trim().Equals(string.Empty) && !ValidationUtils.CheckDateFormat(txt_valid_from.Text))
            {
                messagesGroup += Convert.ToString(errorCounter) + ") " + Resources.Messages.err_date_from_format + "<br /><br />";
                errorCounter++;
                checkForDatesCombination = false;
                isInError = true;
            }

            if (!txt_valid_to.Text.Trim().Equals(string.Empty) && !ValidationUtils.CheckDateFormat(txt_valid_to.Text))
            {
                messagesGroup += Convert.ToString(errorCounter) + ") " + Resources.Messages.err_date_to_format + "<br /><br />";
                errorCounter++;
                checkForDatesCombination = false;
                isInError = true;
            }

            if (!txt_valid_from.Text.Trim().Equals(string.Empty) && !txt_valid_to.Text.Trim().Equals(string.Empty))
            {
                // Controllo congruenza date
                if (checkForDatesCombination)
                {
                    if (!ValidationUtils.CheckDates(txt_valid_from.Text, txt_valid_to.Text))
                    {
                        messagesGroup += Convert.ToString(errorCounter) + ") " + Resources.Messages.err_date_diff + "<br /><br />";
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

            ICodelistMutableObject tmpCodelist = new CodelistMutableCore();

            #region CREATE CODELIST FROM FORM

            tmpCodelist.AgencyId = GetAgencyValue();
            tmpCodelist.Id = txt_id.Text;
            tmpCodelist.Version = txt_version.Text;
            tmpCodelist.FinalStructure = TertiaryBool.ParseBoolean(chk_isFinal.Checked);
            tmpCodelist.Uri = (!txt_uri.Text.Trim().Equals( string.Empty ) && ValidationUtils.CheckUriFormat(txt_uri.Text)) ? new Uri(txt_uri.Text) : null;
            if (!txt_valid_from.Text.Trim().Equals(string.Empty))
            {
                tmpCodelist.StartDate = DateTime.ParseExact(txt_valid_from.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
            if (!txt_valid_to.Text.Trim().Equals(string.Empty))
            {
                tmpCodelist.EndDate = DateTime.ParseExact(txt_valid_to.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
            foreach (var tmpName in AddTextName.TextObjectList)
            {
                tmpCodelist.AddName(tmpName.Locale, tmpName.Value);
            }
            if (AddTextDescription.TextObjectList != null)
                foreach (var tmpDescription in AddTextDescription.TextObjectList)
                {
                    tmpCodelist.AddDescription(tmpDescription.Locale, tmpDescription.Value);
                }
            if (AnnotationGeneralControl.AnnotationObjectList != null)
                foreach (var annotation in AnnotationGeneralControl.AnnotationObjectList)
                {
                    tmpCodelist.AddAnnotation(annotation);
                }
            #endregion

            return tmpCodelist;
        }

        private ICodelistMutableObject GetCodelistForm(ICodelistMutableObject cl)
        {

            if (cl == null) return GetCodelistForm();

            bool isInError = false;                 // Indicatore di errore
            string messagesGroup = string.Empty;    // Stringa di raggruppamento errori
            int errorCounter = 1;                   // Contatore errori

            #region CODELIST ID
            if (!ValidationUtils.CheckIdFormat(txt_id.Text.Trim()))
            {
                messagesGroup += Convert.ToString(errorCounter) + ") " + Resources.Messages.err_id_format + "<br /><br />";
                errorCounter++;
                isInError = true;
            }
            #endregion

            #region CODELIST AGENCY
            if ( cmb_agencies.Text.Trim().Equals( string.Empty ) )
            {
                messagesGroup += Convert.ToString(errorCounter) + ") " + Resources.Messages.err_agency_missing + "<br /><br />";
                errorCounter++;
                isInError = true;
            }
            #endregion

            #region CODELIST VERSION
            if (!ValidationUtils.CheckVersionFormat(txt_version.Text.Trim()))
            {
                messagesGroup += Convert.ToString(errorCounter) + ") " + Resources.Messages.err_version_format + "<br /><br />";
                errorCounter++;
                isInError = true;
            }
            #endregion

            /* URI NOT REQUIRED */
            #region CODELIST URI
            if ((txt_uri.Text != string.Empty) && !ValidationUtils.CheckUriFormat(txt_uri.Text))
            {
                messagesGroup += Convert.ToString(errorCounter) + ") " + Resources.Messages.err_uri_format + "<br /><br />";
                errorCounter++;
                isInError = true;
            }
            #endregion

            #region CODELIST NAMES
            if (AddTextName.TextObjectList == null || AddTextName.TextObjectList.Count == 0)
            {
                messagesGroup += Convert.ToString(errorCounter) + ") " + Resources.Messages.err_list_name_format + "<br /><br />";
                errorCounter++;
                isInError = true;
            }
            #endregion

            #region CODELIST START END DATE
            bool checkForDatesCombination = true;

            if (!txt_valid_from.Text.Trim().Equals(string.Empty) && !ValidationUtils.CheckDateFormat(txt_valid_from.Text))
            {
                messagesGroup += Convert.ToString(errorCounter) + ") " + Resources.Messages.err_date_from_format + "<br /><br />";
                errorCounter++;
                checkForDatesCombination = false;
                isInError = true;
            }

            if (!txt_valid_to.Text.Trim().Equals(string.Empty) && !ValidationUtils.CheckDateFormat(txt_valid_to.Text))
            {
                messagesGroup += Convert.ToString(errorCounter) + ") " + Resources.Messages.err_date_to_format + "<br /><br />";
                errorCounter++;
                checkForDatesCombination = false;
                isInError = true;
            }

            if (!txt_valid_from.Text.Trim().Equals(string.Empty) && !txt_valid_to.Text.Trim().Equals(string.Empty))
            {
                // Controllo congruenza date
                if (checkForDatesCombination)
                {
                    if (!ValidationUtils.CheckDates(txt_valid_from.Text, txt_valid_to.Text))
                    {
                        messagesGroup += Convert.ToString(errorCounter) + ") " + Resources.Messages.err_date_diff + "<br /><br />";
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

            #region CREATE CODELIST FROM FORM

            cl.AgencyId = GetAgencyValue();
            cl.Id = txt_id.Text;
            cl.Version = txt_version.Text;
            cl.FinalStructure = TertiaryBool.ParseBoolean(chk_isFinal.Checked);
            cl.Uri = (!txt_uri.Text.Trim().Equals( string.Empty ) && ValidationUtils.CheckUriFormat(txt_uri.Text)) ? new Uri(txt_uri.Text) : null;
            if (!txt_valid_from.Text.Trim().Equals(string.Empty))
            {
                cl.StartDate = DateTime.ParseExact(txt_valid_from.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
            if (!txt_valid_to.Text.Trim().Equals(string.Empty))
            {
                cl.EndDate = DateTime.ParseExact(txt_valid_to.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
            if (cl.Names.Count != 0)
            {
                cl.Names.Clear();
            }
            foreach (var tmpName in AddTextName.TextObjectList)
            {
                cl.AddName(tmpName.Locale, tmpName.Value);
            }
            if (cl.Descriptions.Count != 0)
            {
                cl.Descriptions.Clear();
            }
            if (AddTextDescription.TextObjectList != null)
                foreach (var tmpDescription in AddTextDescription.TextObjectList)
                {
                    cl.AddDescription(tmpDescription.Locale, tmpDescription.Value);
                }
            if (cl.Annotations.Count != 0)
            {
                cl.Annotations.Clear();
            }
            if (AnnotationGeneralControl.AnnotationObjectList != null)
                foreach (var annotation in AnnotationGeneralControl.AnnotationObjectList)
                {
                    cl.AddAnnotation(annotation);
                }

            #endregion

            return cl;
        }

        private ICodelistMutableObject InsertCodeInCodelist(ICodelistMutableObject cl)
        {
            if (cl == null) return null;

            ICodeMutableObject code = new CodeMutableCore();

            string code_id = txt_id_new.Text.Trim();

            IList<ITextTypeWrapperMutableObject> code_names = AddTextName_new.TextObjectList;
            IList<ITextTypeWrapperMutableObject> code_descs = AddTextDescription_new.TextObjectList;
            string code_parent_id = txt_parentid_new.Text.Trim();
            string code_order_str = txt_order_new.Text.Trim();

            #region CODE ID
            if ( ValidationUtils.CheckIdFormat( code_id ) )
            {
                code.Id = code_id;
            }
            else
            {
                lblErrorOnNewInsert.Text = Resources.Messages.err_id_format;
                Utils.AppendScript( "openPopUp('df-Dimension', 600);" );
                Utils.AppendScript("location.href= '#codes';");
                return null;
            }

            IEnumerable<ICodeMutableObject> codes = (from c in cl.Items where c.Id == code_id select c).OfType<ICodeMutableObject>();
            if (codes.Count() > 0)
            {
                lblErrorOnNewInsert.Text = Resources.Messages.err_id_exist;
                Utils.AppendScript( "openPopUp('df-Dimension', 600);" );
                Utils.AppendScript("location.href= '#codes';");
                return null;
            }
            #endregion

            #region CODE NAMES
            if (code_names != null)
            {
                foreach (var tmpName in code_names)
                {
                    code.AddName(tmpName.Locale, tmpName.Value);
                }
            }
            else
            {
                lblErrorOnNewInsert.Text = Resources.Messages.err_list_name_format;
                Utils.AppendScript( "openPopUp('df-Dimension', 600);" );
                Utils.AppendScript("location.href= '#codes';");
                return null;
            }
            #endregion

            #region CODE DESCRIPTIONS
            if (code_descs != null)
            {
                foreach (var tmpDescription in code_descs)
                {
                    code.AddDescription(tmpDescription.Locale, tmpDescription.Value);
                }
            }
            #endregion

            #region PARANT ID

            if ( code_id.Equals( code_parent_id ) )
            {
                lblErrorOnNewInsert.Text = Resources.Messages.err_parent_id_same_value;
                Utils.AppendScript( "openPopUp('df-Dimension-update', 600 );" );
                Utils.AppendScript("location.href= '#codes';");
                return null;
            }

            if (!code_parent_id.Equals(string.Empty) && ValidationUtils.CheckIdFormat(code_id))
            {
                IEnumerable<ICodeMutableObject> parentCode = (from c in cl.Items where c.Id == code_parent_id select c).OfType<ICodeMutableObject>();
                if (parentCode.Count() > 0)
                    code.ParentCode = code_parent_id;
                else
                {
                    lblErrorOnNewInsert.Text = Resources.Messages.err_parent_id_not_found;
                    Utils.AppendScript( "openPopUp('df-Dimension', 600);" );
                    Utils.AppendScript("location.href= '#codes';");
                    return null;
                }
            }
            #endregion

            #region CODE ORDER
            int tmpOrder = 0;
            if (!code_order_str.Equals(string.Empty) && !int.TryParse( code_order_str, out tmpOrder ) )
            {
                lblErrorOnNewInsert.Text = Resources.Messages.err_order_format_invalid;
                Utils.AppendScript( "openPopUp('df-Dimension', 600);" );
                Utils.AppendScript("location.href= '#codes';");
                return null;
            }
            else
            {
                if ( tmpOrder < 0 )
                {
                    lblErrorOnNewInsert.Text = Resources.Messages.err_order_less_than_zero;
                    Utils.AppendScript( "openPopUp('df-Dimension', 600);" );
                    Utils.AppendScript("location.href= '#codes';");
                    return null;
                }
            }
            #endregion

            int indexOrder;
            if (!int.TryParse(code_order_str, out indexOrder))
                indexOrder = cl.Items.Count + 1;
            else { indexOrder--; }
            if (indexOrder < 0
                || indexOrder > cl.Items.Count) indexOrder = cl.Items.Count;

            cl.Items.Insert(indexOrder, code);

            try
            {
                // Ultimo controllo se ottengo Immutable istanze validazione completa
                var canRead = cl.ImmutableInstance;
            }
            catch (Exception ex)
            {
                cl.Items.RemoveAt(indexOrder);
                return null;
            }
            return cl;
        }

        private IAnnotationMutableObject GetAnnotationOrder(int index)
        {

            IAnnotationMutableObject annotation = new AnnotationMutableCore();
            ITextTypeWrapperMutableObject iText = new TextTypeWrapperMutableCore();
            iText.Value = index.ToString();
            iText.Locale = "en";
            annotation.AddText(iText);
            annotation.Type = "@ORDER@";

            return annotation;
        }

        private ICodelistMutableObject GetCodeListFromSession()
        {
            try
            {
                if (Session[KEY_PAGE_SESSION] == null)
                {
                    if (_artIdentity.ToString() != string.Empty)
                    {
                        WSModel wsModel = new WSModel();
                        ISdmxObjects sdmxObject = wsModel.GetCodeList(_artIdentity, false,false);
                        ICodelistObject cl = sdmxObject.Codelists.FirstOrDefault();

                        ICodelistMutableObject codelistMutableObject = cl.MutableInstance;

                        var sortedCodes = codelistMutableObject.Items.OrderBy<ICodeMutableObject, int>(
                        o =>
                        {
                            var corder = o.Annotations.FirstOrDefault(mutableObject => string.Equals(mutableObject.Type, "@ORDER@"));
                            return corder != null ? int.Parse(corder.Text[0].Value) : 0;
                        }).ToArray();

                        codelistMutableObject.Items.Clear();

                        foreach (ICodeMutableObject code in sortedCodes)
                        {
                            codelistMutableObject.Items.Add(code);
                        }

                        //codelistMutableObject.Items.Add(sortedCodes);

                        //var sortedCodes = codelistMutableObject.Items.OrderBy<ICode, int>(o =>
                        //{
                        //    var corder = o.Annotations.FirstOrDefault(mutableObject => string.Equals(mutableObject.Type, "@ORDER@"));
                        //    return corder != null ? int.Parse(corder.Text[0].Value) : 0;
                        //}).ToArray();

                        Session[KEY_PAGE_SESSION] = codelistMutableObject;
                        //Session[KEY_PAGE_SESSION] = cl.MutableInstance;


                    }
                    else
                    {
                        throw new Exception();
                    }

                }
                return (ICodelistMutableObject)Session[KEY_PAGE_SESSION];
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        private bool SaveInMemory(ICodelistMutableObject cl)
        {
            if (cl == null) return false;

            Session[KEY_PAGE_SESSION] = cl;

            return true;
        }

        private bool SendQuerySubmit(ICodelistMutableObject cl)
        {
            try
            {
                ISdmxObjects sdmxObjects = new SdmxObjectsImpl();

                int indexOrder = 1;
                foreach (ICodeMutableObject code in cl.Items)
                {
                    IEnumerable<IAnnotationMutableObject> annotations = (from a in code.Annotations where a.Type == "@ORDER@" select a).OfType<IAnnotationMutableObject>();

                    
                    if (annotations.Count() > 0)
                    {
                        IAnnotationMutableObject annotation = annotations.First();

                        ITextTypeWrapperMutableObject iText = new TextTypeWrapperMutableCore();

                        iText.Value = (indexOrder++).ToString();
                        iText.Locale = "en";

                        annotation.Text.Clear();
                        annotation.Text.Add(iText);

                    }
                    else { 
                        code.AddAnnotation(GetAnnotationOrder(indexOrder++));
                    }
                    lblCodeListDetail.Text = code.Names[0].Value ;
                }

                sdmxObjects.AddCodelist(cl.ImmutableInstance);
                WSModel modelCodeList = new WSModel();
                XmlDocument result = modelCodeList.SubmitStructure(sdmxObjects);
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

        private int CurrentCodeIndex { get { return (int)Session[KEY_PAGE_SESSION + "_index_code"]; } set { Session[KEY_PAGE_SESSION + "_index_code"] = value; } }

        #region Event Handler

        protected void Page_Load(object sender, EventArgs e)
        {
            _localizedUtils = new LocalizedUtils(Utils.LocalizedCulture);

            SetAction();

            if (!IsPostBack)
            {
                Utils.PopulateCmbAgencies(cmb_agencies, true);
                Utils.PopulateCmbAgencies(cmbLanguageForCsv, true);
                ClearSessionPage();
                ViewState["SortExpr"] = SortDirection.Ascending;
                txtNumberOfRows.Text = Utils.DetailsCodelistGridNumberRow.ToString();
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

                    chk_isFinal.Checked = false;
                    chk_isFinal.Enabled = false;

                    AddTextName_update.ucOpenTabName = "codes";        
                    AddTextName_update.ucOpenPopUpWidth = 600;                
                    AddTextName_update.ucOpenPopUpName = "df-Dimension-update";

                    AddTextDescription_update.ucOpenTabName = "codes";
                    AddTextDescription_update.ucOpenPopUpWidth = 600;
                    AddTextDescription_update.ucOpenPopUpName = "df-Dimension-update";

                    AddTextName_new.ucOpenTabName = "codes";
                    AddTextName_new.ucOpenPopUpWidth = 600;
                    AddTextName_new.ucOpenPopUpName = "df-Dimension"; 

                    AddTextDescription_new.ucOpenTabName = "codes";
                    AddTextDescription_new.ucOpenPopUpWidth = 600;
                    AddTextDescription_new.ucOpenPopUpName = "df-Dimension";
                    if ( !Page.IsPostBack )
                    {
                        cmb_agencies.Items.Insert(0, new ListItem(String.Empty, String.Empty));
                        cmb_agencies.SelectedIndex = 0;

                        FileDownload31.Visible = false;
                    }
                    break;
                case Action.UPDATE:

                    _artIdentity = Utils.GetIdentityFromRequest(Request);

                    SetInitControls();
                    SetEditForm();

                    AddTextName_update.ucOpenTabName = "codes";
                    AddTextName_update.ucOpenPopUpWidth = 600;
                    AddTextName_update.ucOpenPopUpName = "df-Dimension-update";

                    AddTextDescription_update.ucOpenTabName = "codes";
                    AddTextDescription_update.ucOpenPopUpWidth = 600;
                    AddTextDescription_update.ucOpenPopUpName = "df-Dimension-update";

                    AddTextName_new.ucOpenTabName = "codes";
                    AddTextName_new.ucOpenPopUpWidth = 600;
                    AddTextName_new.ucOpenPopUpName = "df-Dimension"; 

                    AddTextDescription_new.ucOpenTabName = "codes";
                    AddTextDescription_new.ucOpenPopUpWidth = 600;
                    AddTextDescription_new.ucOpenPopUpName = "df-Dimension";

                    /*if (gvCodelistsItem.Rows.Count > 0 )
                    {
                        chk_isFinal.Enabled = true;
                    }
                    else
                    {
                        chk_isFinal.Enabled = false;
                    }*/
                    break;
                case Action.VIEW:

                    _artIdentity = Utils.GetIdentityFromRequest(Request);
                    ClearSessionPage();
                    SetViewForm();

                    AddTextName_update.ucOpenTabName = "codes";
                    AddTextName_update.ucOpenPopUpWidth = 600;
                    AddTextName_update.ucOpenPopUpName = "df-Dimension-update";

                    AddTextDescription_update.ucOpenTabName = "codes";
                    AddTextDescription_update.ucOpenPopUpWidth = 600;
                    AddTextDescription_update.ucOpenPopUpName = "df-Dimension-update";

                    AddTextName_new.ucOpenTabName = "codes";
                    AddTextName_new.ucOpenPopUpWidth = 600;
                    AddTextName_new.ucOpenPopUpName = "df-Dimension"; 

                    AddTextDescription_new.ucOpenTabName = "codes";
                    AddTextDescription_new.ucOpenPopUpWidth = 600;
                    AddTextDescription_new.ucOpenPopUpName = "df-Dimension";


                    FileDownload31.ucID = _artIdentity.ID;
                    FileDownload31.ucAgency = _artIdentity.Agency;
                    FileDownload31.ucVersion = _artIdentity.Version;
                    FileDownload31.ucArtefactType = "CodeList";
                    break;
            }

            DuplicateArtefact1.ucStructureType = SdmxStructureEnumType.CodeList;
            DuplicateArtefact1.ucMaintanableArtefact = GetCodeListFromSession();

            lbl_id.DataBind();
            lbl_agency.DataBind();
            lbl_version.DataBind();
            lbl_isFinal.DataBind();
            lbl_uri.DataBind();
            lbl_urn.DataBind();
            lbl_valid_from.DataBind();
            lbl_valid_to.DataBind();
            lbl_name.DataBind();
            lbl_description.DataBind();
            lbl_annotation.DataBind();
            btnChangePaging.DataBind();
            lblImportCsvTitle.DataBind();
            lblCsvLanguage.DataBind();
            lblcsvFile.DataBind();
            lblNoItemsPresent.DataBind();
            lbl_title_popup_code.DataBind();

            lbl_id_update.DataBind();
            lbl_order_update.DataBind();
            lbl_parentid_update.DataBind();
            lbl_description_update.DataBind();
            lbl_name_update.DataBind();
            lbl_title_update.DataBind();
            lbl_id_new.DataBind();
            lbl_order_new.DataBind();
            lbl_parentid_new.DataBind();
            lbl_description_new.DataBind();
            lbl_name_new.DataBind();
            btnClearFields.DataBind();
            btnClearFieldForUpdate.DataBind();
            imgImportCsv.DataBind();
            btnAddNewCode.DataBind();
            btnSaveMemoryCodeList.DataBind();
            btnImportFromCsv.DataBind();
            btnSaveAnnotationCode.DataBind();
            btnUpdateCode.DataBind();
            btnNewCode.DataBind();
            lblNumberOfRows.DataBind();
            lblSeparator.DataBind();
            btnNewCodeOnFinalStructure.DataBind();
            lblYouAreWorkingOnAFinal.DataBind();
        }

        protected void gvCodelistsItem_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvCodelistsItem.PageSize = 12;
            gvCodelistsItem.PageIndex = e.NewPageIndex;
            BindData();
            Utils.AppendScript("location.href= '#codes';");
        }

        protected void btnSaveAnnotationCode_Click(object sender, EventArgs e) {

            ICodelistMutableObject cl = GetCodeListFromSession();

            if (!SaveInMemory(cl)) return;

            BindData();

            Utils.AppendScript("location.href='#codes';");
        }

        protected void btnSaveMemoryCodeList_Click(object sender, EventArgs e)
        {
            ICodelistMutableObject cl = GetCodeListFromSession();
            if (cl == null) cl = GetCodelistForm();
            else cl = GetCodelistForm(cl);

            if (!SaveInMemory(cl)) return;

            if (!SendQuerySubmit(cl)) return;

            BindData();

            string successMessage = string.Empty;
            if (((Action)Enum.Parse(typeof(Action), Request["ACTION"].ToString())) == Action.INSERT)
            {
                successMessage = Resources.Messages.succ_codelist_insert;
            }
            else if (((Action)Enum.Parse(typeof(Action), Request["ACTION"].ToString())) == Action.UPDATE)
            {
                successMessage = Resources.Messages.succ_codelist_update;
            }
            Utils.ShowDialog(successMessage, 300, Resources.Messages.succ_operation);
            if ( _action == Action.INSERT )
            {
                Utils.AppendScript( "location.href='./codelists.aspx'" );
            }
        }

        protected void btnAddNewCode_Click(object sender, EventArgs e)
        {
            ICodelistMutableObject cl = GetCodeListFromSession();
            cl = GetCodelistForm(cl);
                  
            // form codelist validation
            if (cl == null) 
            {
                txt_id_new.Text = string.Empty;
                txt_parentid_new.Text = string.Empty;
                txt_order_new.Text = string.Empty;
                AddTextName_new.ClearTextObjectListWithOutJS();
                AddTextDescription_new.ClearTextObjectListWithOutJS();
                lblErrorOnNewInsert.Text = string.Empty;
                return;
            }

            cl = InsertCodeInCodelist(cl);

            if (cl == null) 
            {
                txt_id_new.Text = string.Empty;
                txt_parentid_new.Text = string.Empty;
                txt_order_new.Text = string.Empty;
                AddTextName_new.ClearTextObjectListWithOutJS();
                AddTextDescription_new.ClearTextObjectListWithOutJS();
//                Utils.ShowDialog(Resources.Messages.err_code_insert, 300, Resources.Messages.err_title);
//                Utils.AppendScript("location.href= '#codes';");
                return;
            }

            if (!SaveInMemory(cl)) 
            {
                txt_id_new.Text = string.Empty;
                txt_parentid_new.Text = string.Empty;
                txt_order_new.Text = string.Empty;
                AddTextName_new.ClearTextObjectListWithOutJS();
                AddTextDescription_new.ClearTextObjectListWithOutJS();
                lblErrorOnNewInsert.Text = string.Empty;
                return;
            }

            BindData();

            txt_id_new.Text = string.Empty;
            txt_parentid_new.Text = string.Empty;
            txt_order_new.Text = string.Empty;
            AddTextName_new.ClearTextObjectListWithOutJS();
            AddTextDescription_new.ClearTextObjectListWithOutJS();
            lblErrorOnNewInsert.Text = string.Empty;
            Utils.AppendScript("location.href='#codes';");
        }

        protected void btnUpdateCode_Click(object sender, EventArgs e)
        {
            // Get Input field
            string code_id = txt_id_update.Text.Trim();
            IList<ITextTypeWrapperMutableObject> code_names = AddTextName_update.TextObjectList;
            IList<ITextTypeWrapperMutableObject> code_descs = AddTextDescription_update.TextObjectList;
            string code_parent_id = txt_parentid_update.Text.Trim();
            string code_order_str = txt_order_update.Text.Trim();

            // Get Current Object Session
            ICodelistMutableObject cl = cl = GetCodeListFromSession();
            IEnumerable<ICodeMutableObject> _rc = (from x in cl.Items where x.Id == code_id select x).OfType<ICodeMutableObject>();
            if (_rc.Count() == 0) return;

            ICodeMutableObject code = _rc.First();

            ICodeMutableObject _bCode = new CodeMutableCore();

            int indexCode = cl.Items.IndexOf(code);
            int indexOrder=0;
            try
            {

                #region CODE ID
                if (!code_id.Equals(string.Empty) && ValidationUtils.CheckIdFormat(code_id))
                {
                    _bCode.Id = code_id;
                }
                else
                {
                    lblErrorOnUpdate.Text = Resources.Messages.err_id_format;
                    Utils.AppendScript( "openPopUp('df-Dimension-update', 600 );" );
                    Utils.AppendScript("location.href= '#codes';");
                    return;
                }
                #endregion

                #region CODE NAMES
                if (code_names != null)
                {
                    foreach (var tmpName in code_names)
                    {
                        _bCode.AddName(tmpName.Locale, tmpName.Value);
                    }
                }
                else
                {
                    lblErrorOnUpdate.Text = Resources.Messages.err_list_name_format;
                    Utils.AppendScript( "openPopUp('df-Dimension-update', 600 );" );
                    Utils.AppendScript("location.href= '#codes';");
                    return;
                }
                #endregion

                #region CODE DESCRIPTIONS
                if (code_descs != null)
                {
                    foreach (var tmpDescription in code_descs)
                    {
                        _bCode.AddDescription(tmpDescription.Locale, tmpDescription.Value);
                    }
                }
                #endregion

                #region PARANT ID
                
                if ( code_id.Equals( code_parent_id ) )
                {
                    lblErrorOnUpdate.Text = Resources.Messages.err_parent_id_same_value;
                    Utils.AppendScript( "openPopUp('df-Dimension-update', 600 );" );
                    Utils.AppendScript("location.href= '#codes';");
                    return;
                }

                if (!code_parent_id.Equals(string.Empty) && ValidationUtils.CheckIdFormat(code_id))
                {
                    IEnumerable<ICodeMutableObject> parentCode = (from c in cl.Items where c.Id == code_parent_id select c).OfType<ICodeMutableObject>();
                    if (parentCode.Count() > 0)
                        _bCode.ParentCode = code_parent_id;
                    else
                    {
                        lblErrorOnUpdate.Text = Resources.Messages.err_parent_id_not_found;
                        Utils.AppendScript( "openPopUp('df-Dimension-update', 600 );" );
                        Utils.AppendScript("location.href= '#codes';");
                        return;
                    }
                }
                #endregion

                #region CODE ORDER
                int tmpOrder = 0;
                if (!code_order_str.Equals(string.Empty) && !int.TryParse( code_order_str, out tmpOrder ) )
                {
                    lblErrorOnUpdate.Text = Resources.Messages.err_order_format_invalid;
                    Utils.AppendScript( "openPopUp('df-Dimension-update', 600);" );
                    Utils.AppendScript("location.href= '#codes';");
                    return;
                } 
                else
                {
                    if ( tmpOrder < 0 )
                    {
                        lblErrorOnUpdate.Text = Resources.Messages.err_order_less_than_zero;
                        Utils.AppendScript( "openPopUp('df-Dimension-update', 600);" );
                        Utils.AppendScript("location.href= '#codes';");
                        return;
                    }
                }
                #endregion
#region ANNOTATIONS

                foreach ( IAnnotationMutableObject annotation in cl.Items.ElementAt(indexCode).Annotations )
                {
                    _bCode.AddAnnotation( annotation );
                }

#endregion
                if (!int.TryParse(code_order_str, out indexOrder))
                    indexOrder = cl.Items.Count + 1;
                else { indexOrder--; }
                if (indexOrder < 0
                    || indexOrder >= cl.Items.Count) indexOrder = cl.Items.Count - 1;

                cl.Items.RemoveAt(indexCode);
                cl.Items.Insert(indexOrder, _bCode);
                
                // Ultimo controllo se ottengo Immutable istanze validazione completa
                var canRead = cl.ImmutableInstance;

            }
            catch (Exception ex)
            {
                cl.Items.RemoveAt(indexOrder);
                cl.Items.Insert(indexCode, code);
                if ( ex.Message.Contains( "- 706 -" ) )
                {
                    lblErrorOnUpdate.Text = Resources.Messages.err_parent_item_is_child;
                    Utils.AppendScript( "openPopUp('df-Dimension-update', 600);" );
                 }
                else
                {
                    lblErrorOnUpdate.Text = Resources.Messages.err_code_update;
                    Utils.AppendScript( "openPopUp('df-Dimension-update', 600);" );
                }
                Utils.AppendScript("location.href='#codes';"); 
                return;
            }

            if (!SaveInMemory(cl))
                return;

            BindData();
            Utils.AppendScript("location.href='#codes';");            
        }

        protected void gvCode_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "UPDATE":
                    {
                        // Svuoto i controlli
                        // ---------------------------------
                        txt_id_update.Text = string.Empty;
                        txt_order_update.Text = string.Empty;
                        txt_parentid_update.Text = string.Empty;
                        AddTextName_update.ClearTextObjectList();
                        AddTextDescription_update.ClearTextObjectList();
                        // ---------------------------------

                        GridViewRow gvr = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);
                        txt_id_update.Text = ((Label)gvr.Cells[1].Controls[1]).Text;
                        txt_parentid_update.Text = ((Label)gvr.Cells[3].Controls[1]).Text;

                        ICodelistMutableObject cl = GetCodeListFromSession();

                        if (gvr.RowIndex < 0 && gvr.RowIndex > cl.ImmutableInstance.Items.Count) return;

                        if ( gvCodelistsItem.PageIndex > 0 )
                        {
                            CurrentCodeIndex = gvr.RowIndex + ( gvCodelistsItem.PageIndex * gvCodelistsItem.PageSize );
                        }
                        else
                        {
                             CurrentCodeIndex = gvr.RowIndex;
                        }

                        ICode currentCode = ((ICode)cl.ImmutableInstance.Items[CurrentCodeIndex]);

                        AddTextName_update.ArtefactType = Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.Code;
                        AddTextName_update.TType = TextType.NAME;
                        AddTextName_update.ClearTextObjectList();
                        AddTextName_update.InitTextObjectList = currentCode.Names;

                        AddTextDescription_update.ArtefactType = Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.Code;
                        AddTextDescription_update.TType = TextType.DESCRIPTION;
                        AddTextDescription_update.ClearTextObjectList();
                        AddTextDescription_update.InitTextObjectList = currentCode.Descriptions;
                        
                        txt_order_update.Text = (CurrentCodeIndex + 1).ToString();



                    } break;
                case "DELETE":
                    {

                        GridViewRow gvr = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);

                        ICodelistMutableObject cl = GetCodeListFromSession();

                        if (gvr.RowIndex < 0 && gvr.RowIndex > cl.Items.Count) return;

                        bool canDelete = true;
                        var parent_code = cl.Items[gvr.RowIndex].Id;

                        #region PARANT ID
                        if (parent_code != null)
                        {
                            IEnumerable<ICodeMutableObject> parentCode = (from c in cl.Items where c.ParentCode == parent_code select c).OfType<ICodeMutableObject>();
                            if (parentCode.Count() > 0)
                            {
                                Utils.ShowDialog(Resources.Messages.err_code_is_parent, 300, Resources.Messages.err_title);
                                Utils.AppendScript("location.href= '#codes';");

                                canDelete = false;
                            }
                        }
                        #endregion

                        if (canDelete)
                        {
                            cl.Items.RemoveAt(gvr.RowIndex);

                            Session[KEY_PAGE_SESSION] = cl;

                            BindData();
                        }
                        if ( gvCodelistsItem.Rows.Count == 0 )
                        {
                            chk_isFinal.Enabled = false;
                            chk_isFinal.Checked = false;
                        }
                        Utils.AppendScript("location.href='#codes'");

                    } break;
                case "ANNOTATION": {

                    ICodelistMutableObject cl = GetCodeListFromSession();
                    //cl = GetCodelistForm(cl);

                    GridViewRow gvr = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);

                    if (gvr.RowIndex < 0 && gvr.RowIndex > cl.Items.Count) return;

                    if ( gvCodelistsItem.PageIndex > 0 )
                    {
                        CurrentCodeIndex = gvr.RowIndex + ( gvCodelistsItem.PageIndex * gvCodelistsItem.PageSize );
                    }
                    else
                    {
                         CurrentCodeIndex = gvr.RowIndex;
                    }
                    ctr_annotation_update.AnnotationObjectList = cl.Items[CurrentCodeIndex].Annotations;
            
                    Utils.AppendScript("openP('code_annotation',650);");
                    Utils.AppendScript("location.href= '#codes';");

                } break;
            }

        }
        protected void gvCodelistsItem_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // NULL
        }
        protected void gvCodelistsItem_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // NULL
        }
        protected void gvCodelistsItem_Sorting(object sender, GridViewSortEventArgs e)
        {
            ICodelistMutableObject cl = GetCodeListFromSession();

            if (cl == null) return;

            LocalizedUtils localUtils = new LocalizedUtils(Utils.LocalizedCulture);
            EntityMapper eMapper = new EntityMapper(Utils.LocalizedLanguage);

            IList<CodeItem> lCodeListItem = new List<CodeItem>();
            foreach (ICode code in cl.ImmutableInstance.Items)
            {
                lCodeListItem.Add(new CodeItem(code.Id, localUtils.GetNameableName(code), localUtils.GetNameableDescription(code), code.ParentCode));
            }

            if ((SortDirection)ViewState["SortExpr"] == SortDirection.Ascending)
            {
                lCodeListItem = lCodeListItem.OrderBy(x => TypeHelper.GetPropertyValue(x, e.SortExpression)).Reverse().ToList();
                ViewState["SortExpr"] = SortDirection.Descending;
            }
            else
            {
                lCodeListItem = lCodeListItem.OrderBy(x => TypeHelper.GetPropertyValue(x, e.SortExpression)).ToList();
                ViewState["SortExpr"] = SortDirection.Ascending;
            }
            int numberOfRows = 0;
            if ( !txtNumberOfRows.Text.Trim().Equals( string.Empty ) && int.TryParse( txtNumberOfRows.Text, out numberOfRows ) )
            {
                gvCodelistsItem.PageSize = numberOfRows;
            }
            else if ( txtNumberOfRows.Text.Trim().Equals( string.Empty ) )
            {
                    gvCodelistsItem.PageSize = Utils.DetailsCodelistGridNumberRow;
            }
            gvCodelistsItem.DataSource = lCodeListItem;
            gvCodelistsItem.DataBind();
            Utils.AppendScript( "location.href='#codes'" );
        }

        protected void gvCodelistsItem_Sorted(object sender, EventArgs e)
        {

        }
        protected void btnImportFromCsv_Click(object sender, EventArgs e)
        {
            if ( !csvFile.HasFile )
            {
                Utils.AppendScript( "openPopUp( 'importCsv' );" );
                Utils.AppendScript( "location.href='#codes'" );
                Utils.AppendScript( string.Format( "alert( '{0}' );", Resources.Messages.err_no_file_uploaded ) );
                return;
            }

            ICodelistMutableObject cl = GetCodeListFromSession();

            if (cl == null) return;

            List<csvCode> codes = new List<csvCode>();
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
                csvFile.SaveAs(Server.MapPath("~/csv_codelists_files/") + filename);

                reader = new StreamReader(Server.MapPath("~/csv_codelists_files/") + filename);
                logWriter = new StreamWriter(Server.MapPath("~/csv_codelists_import_logs/") + logFilename, true);
                logWriter.WriteLine(string.Format("LOG RELATIVO A CARICAMENTO DELLA CODELIST [ ID => \"{0}\"  AGENCY_ID => \"{1}\"  VERSION => \"{2}\" ]  |  LINGUA SELEZIONATA: {3}\n", cl.Id.ToString(), cl.AgencyId.ToString(), cl.Version.ToString(), cmbLanguageForCsv.SelectedValue.ToString()));
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
                    if (fields[0].Trim().Equals("\"\"") || fields[0].Trim().Equals( string.Empty ))
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
                    if (fields[1].Trim().Equals("\"\"") || fields[1].Trim().Equals( string.Empty ))
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
                    codes.Add(new csvCode(fields[0].ToString().Replace("\"", ""), fields[1].ToString().Replace("\"", ""), fields[2].ToString().Replace("\"", ""), fields[3].ToString().Replace("\"", "")));
                    currentRow++;
                }
                
            }
            catch (Exception ex)
            {
                Utils.AppendScript(string.Format("Upload status: The file could not be uploaded. The following error occured: {0}", ex.Message));
            }

            foreach (csvCode code in codes)
            {
                if ( !code.parentCode.Trim().Equals( string.Empty ) )
                {
                    int cont = (from myCode in cl.Items 
                                where myCode.Id.Equals( code.parentCode )
                                select myCode).Count();
                    if ( cont == 0 )
                    {
                        errorInUploading = true;
                        wrongRowsMessageForUser += string.Format(Resources.Messages.err_csv_import_parent_code_error, code.parentCode, code.code, code.code );     
                        continue;
                    }
                }
                ICodeMutableObject tmpCode = cl.GetCodeById(code.code);
                if (tmpCode == null)
                {
                    tmpCode = new CodeMutableCore();
                    tmpCode.Id = code.code;
                    tmpCode.ParentCode = code.parentCode;
                    tmpCode.AddName(cmbLanguageForCsv.SelectedValue.ToString(), code.name);
                    tmpCode.AddDescription(cmbLanguageForCsv.SelectedValue.ToString(), code.description);
                    cl.AddItem(tmpCode);
                }
                else
                {
                    tmpCode.Id = code.code;
                    tmpCode.ParentCode = code.parentCode;
                    tmpCode.AddName(cmbLanguageForCsv.SelectedValue.ToString(), code.name);
                    tmpCode.AddDescription(cmbLanguageForCsv.SelectedValue.ToString(), code.description);
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

            if (!SaveInMemory(cl)) return;

            BindData();
            if ( !errorInUploading )
            {
                Utils.ShowDialog( Resources.Messages.succ_operation );
            }
            Utils.AppendScript("location.href='#codes'");
        }

        #endregion

        #region LAYOUT

        private void SetLabelDetail()
        {
            ICodelistMutableObject cl = GetCodeListFromSession();
            
            if(cl==null)
                lblCodeListDetail.Text = String.Format("({0}+{1}+{2})", _artIdentity.ID, _artIdentity.Agency, _artIdentity.Version);
            else{

                lblCodeListDetail.Text = String.Format("{3} ({0}+{1}+{2})", _artIdentity.ID, _artIdentity.Agency, _artIdentity.Version, _localizedUtils.GetNameableName(cl.ImmutableInstance));
            }

        }

        private void BindData(bool isNewItem = false)
        {
            ICodelistMutableObject cl = GetCodeListFromSession();

            if (cl == null) return;

            SetGeneralTab(cl.ImmutableInstance);

            LocalizedUtils localUtils = new LocalizedUtils(Utils.LocalizedCulture);
            EntityMapper eMapper = new EntityMapper(Utils.LocalizedLanguage);

            IList<CodeItem> lCodeListItem = new List<CodeItem>();
            foreach (ICode code in cl.ImmutableInstance.Items)
            {
                lCodeListItem.Add(new CodeItem(code.Id, localUtils.GetNameableName(code), localUtils.GetNameableDescription(code), code.ParentCode));
            }

            int numberOfRows = 0;

            if ( !txtNumberOfRows.Text.Trim().Equals( string.Empty ) && int.TryParse( txtNumberOfRows.Text, out numberOfRows ) )
            {
                gvCodelistsItem.PageSize = numberOfRows;
            }
            else
            {
                gvCodelistsItem.PageSize = Utils.DetailsCodelistGridNumberRow;
            }
            int numberOfTotalElements = lCodeListItem.Count;
            lblNumberOfTotalElements.Text = string.Format( Resources.Messages.lbl_number_of_total_rows, numberOfTotalElements.ToString() );
            gvCodelistsItem.DataSource = lCodeListItem;
            gvCodelistsItem.DataBind();

            if ( lCodeListItem.Count == 0 )
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

        private void SetGeneralTab(ICodelistObject cl)
        {
            txt_id.Text = cl.Id;
            txtAgenciesReadOnly.Text = cl.AgencyId;
            txt_version.Text = cl.Version;
            chk_isFinal.Checked = cl.IsFinal.IsTrue;

            FileDownload31.ucID = cl.Id;
            FileDownload31.ucAgency = cl.AgencyId;
            FileDownload31.ucVersion = cl.Version;
            FileDownload31.ucArtefactType = "CodeList";
 
            txt_uri.Text = (cl.Uri != null) ? cl.Uri.AbsoluteUri : string.Empty;
            txt_urn.Text = (cl.Urn != null) ? cl.Urn.AbsoluteUri : string.Empty;
            txt_valid_from.Text = (cl.StartDate != null) ? string.Format("{0}/{1}/{2}", cl.StartDate.Date.Value.Day.ToString(), cl.StartDate.Date.Value.Month.ToString(), cl.StartDate.Date.Value.Year.ToString()) : string.Empty;
            txt_valid_to.Text = (cl.EndDate != null) ? string.Format("{0}/{1}/{2}", cl.EndDate.Date.Value.Day.ToString(), cl.EndDate.Date.Value.Month.ToString(), cl.EndDate.Date.Value.Year.ToString()) : string.Empty;

            txt_name_locale.Text = _localizedUtils.GetNameableName(cl);
            txt_description_locale.Text = _localizedUtils.GetNameableDescription(cl);

            // Svuoto le griglie 
            //===========================================
            if (AddTextName.TextObjectList != null && AddTextName.TextObjectList.Count != 0)
            {
                AddTextName.ClearTextObjectList();
            }
            if (AddTextDescription.TextObjectList != null && AddTextDescription.TextObjectList.Count != 0)
            {
                AddTextDescription.ClearTextObjectList();
            }
            if (AnnotationGeneralControl.AnnotationObjectList != null && AnnotationGeneralControl.AnnotationObjectList.Count != 0)
            {
                AnnotationGeneralControl.ClearAnnotationsSession();
            }

            txt_id.Enabled = false;
            txt_version.Enabled = false;
            cmb_agencies.Enabled = false;

            if (_action == Action.VIEW || cl.IsFinal.IsTrue)
            {
                AddTextName.Visible = false;
                txt_all_names.Visible = true;
                txt_all_names.Text = _localizedUtils.GetNameableName(cl);

                AddTextDescription.Visible = false;
                txt_all_description.Visible = true;
                txt_all_description.Text = _localizedUtils.GetNameableDescription(cl);
                Utils.ResetBeforeUnload();
            }
            else
            {
                AspConfirmationExit = "true";

                AddTextName.Visible = true;
                AddTextDescription.Visible = true;
                txt_all_description.Visible = false;
                txt_all_names.Visible = false;
                
                AddTextName.InitTextObjectList = cl.Names;
                AddTextDescription.InitTextObjectList = cl.Descriptions;
            }

            if ( _action != Action.VIEW )
            {
                DuplicateArtefact1.Visible = true;
            }

            AnnotationGeneralControl.AddText_ucOpenTabName = AnnotationGeneralControl.ClientID;
            AnnotationGeneralControl.AnnotationObjectList = cl.MutableInstance.Annotations;
            AnnotationGeneralControl.EditMode = (cl.IsFinal.IsTrue || _action == Action.VIEW) ? false :true;
            AnnotationGeneralControl.OwnerAgency =  txtAgenciesReadOnly.Text;
            ctr_annotation_update.EditMode = (cl.IsFinal.IsTrue || _action == Action.VIEW) ? false : true;

            if (_action == Action.VIEW || cl.IsFinal.IsTrue)
            {
                txt_valid_from.Enabled = false;
                txt_valid_to.Enabled = false;
                txt_name_locale.Enabled = false;
                txt_description_locale.Enabled = false;
                txt_uri.Enabled = false;
                chk_isFinal.Enabled = false;
            }
            else
            {
                txt_valid_from.Enabled = true;
                txt_valid_to.Enabled = true;
                txt_name_locale.Enabled = true;
                txt_description_locale.Enabled = true;
                txt_uri.Enabled = true;
                chk_isFinal.Enabled = true;
            }

            //===========================================

            if ( _action == Action.INSERT )
            {
                cmb_agencies.Visible = true;
                txtAgenciesReadOnly.Visible = false;
            }
            else
            {
                cmb_agencies.Visible = false;
                txtAgenciesReadOnly.Visible = true;
            }

            SetCodeDetailPanel(cl);
        }
        private void SetCodeDetailPanel(ICodelistObject cl)
        {
            // Verifico se la codelist è final
            if (cl.IsFinal.IsTrue || _action == Action.VIEW)
            {
                // Se final il pulsante di add e le colonne di modifica
                // dei codici non devono apparire
                btnSaveMemoryCodeList.Visible = false;
                if ( _action == Action.VIEW )
                {
                    btnAddNewCode.Visible = false;
                }
                else
                {
                    if ( cl.IsFinal.IsTrue )
                    {
                        btnNewCodeOnFinalStructure.Visible = true;
                        btnNewCode.Visible = false;
                        txt_order_new.Visible = false;
                        lbl_order_new.Visible = false;
                        lblYouAreWorkingOnAFinal.Visible = true;
                    }
                }
                AddTextName_update.ucEditMode = false;
                AddTextDescription_update.ucEditMode = false;
                txt_parentid_update.Enabled = false;
                txt_order_update.Enabled = false;
                AnnotationGeneralControl.EditMode = false;
                btnSaveAnnotationCode.Enabled = false;
                btnUpdateCode.Enabled = false;
                //gvCodelistsItem.Columns[gvCodelistsItem.Columns.Count - 1].Visible = false;
                gvCodelistsItem.Columns[gvCodelistsItem.Columns.Count - 2].Visible = false;
                //gvCodelistsItem.Columns[gvCodelistsItem.Columns.Count - 3].Visible = false;
                cmbLanguageForCsv.Visible = false;
                imgImportCsv.Visible = false;
            }
            else
            {
                btnSaveMemoryCodeList.Visible = true;
                btnAddNewCode.Visible = true;
                gvCodelistsItem.Columns[gvCodelistsItem.Columns.Count - 1].Visible = true;
                gvCodelistsItem.Columns[gvCodelistsItem.Columns.Count - 2].Visible = true;
                gvCodelistsItem.Columns[gvCodelistsItem.Columns.Count - 3].Visible = true;
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
                btnSaveMemoryCodeList.Visible = true;
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
                btnSaveMemoryCodeList.Visible = false;
            }
        }
        private void SetEditingControl()
        {
            txt_id.Enabled = true;
            txt_version.Enabled = true;
            txt_uri.Enabled = true;
            txt_valid_from.Enabled = true;
            txt_valid_to.Enabled = true;
            txt_name_locale.Enabled = true;
            txt_description_locale.Enabled = true;
            cmb_agencies.Enabled = true;
            chk_isFinal.Enabled = true;
            pnlEditName.Visible = true;
            pnlEditDescription.Visible = true;
            btnSaveMemoryCodeList.Visible = true;

            // Svuoto le griglie di name e description
            if (_action == Action.INSERT && !Page.IsPostBack)
            {
                AddTextName.ClearTextObjectList();
                AddTextDescription.ClearTextObjectList();
                AnnotationGeneralControl.ClearAnnotationsSession();
            }
        }
        private void SetInitControls()
        {
            AddTextName.TType = TextType.NAME;
            AddTextName.ArtefactType = Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.CodeList;
            
            AddTextDescription.TType = TextType.DESCRIPTION;
            AddTextDescription.ArtefactType = Org.Sdmxsource.Sdmx.Api.Constants.SdmxStructureEnumType.CodeList;

            AddTextName_new.TType = TextType.NAME;
            AddTextDescription_new.TType = TextType.DESCRIPTION;

            AddTextName_update.TType = TextType.NAME;
            AddTextDescription_update.TType = TextType.DESCRIPTION;
        }
        private void GetSDMXObjects()
        {
            _sdmxObjects = (ISdmxObjects)Session["SDMXObjexts"];
        }
        private void SetSDMXObjects()
        {
            Session["SDMXObjexts"] = _sdmxObjects;
        }

        protected void txtNumberOfRows_TextChanged(object sender, EventArgs e)
        {  
        }

        #endregion        

        protected void btnClearFields_Click(object sender, EventArgs e)
        {
            txt_id_new.Text = string.Empty;
            AddTextName_new.ClearTextObjectListWithOutJS();
            AddTextDescription_new.ClearTextObjectListWithOutJS();
            txt_parentid_new.Text = string.Empty;
            txt_order_new.Text = string.Empty;
            lblErrorOnNewInsert.Text = string.Empty;
            //Utils.AppendScript( "openPopUp( 'df-Dimension', 600 );" );
            Utils.AppendScript("location.href= '#codes';");
        }

        protected void btnClearFieldsForUpdate_Click(object sender, EventArgs e)
        {
            lblErrorOnUpdate.Text = string.Empty;
            Utils.AppendScript("location.href= '#codes';");
        }

        protected void btnChangePaging_Click(object sender, EventArgs e)
        {
            ICodelistMutableObject cl = GetCodeListFromSession();

            if (cl == null) return;

            LocalizedUtils localUtils = new LocalizedUtils(Utils.LocalizedCulture);
            EntityMapper eMapper = new EntityMapper(Utils.LocalizedLanguage);

            IList<CodeItem> lCodeListItem = new List<CodeItem>();
            foreach (ICode code in cl.ImmutableInstance.Items)
            {
                lCodeListItem.Add(new CodeItem(code.Id, localUtils.GetNameableName(code), localUtils.GetNameableDescription(code), code.ParentCode));
            }

            int numberOfRows = 0;
            if ( !txtNumberOfRows.Text.Trim().Equals( string.Empty ) && int.TryParse( txtNumberOfRows.Text, out numberOfRows ) )
            {
                if ( numberOfRows > 0 )
                {
                    gvCodelistsItem.PageSize = numberOfRows;
                }
                else
                {
                    gvCodelistsItem.PageSize = Utils.DetailsCodelistGridNumberRow;
                    txtNumberOfRows.Text = Utils.DetailsCodelistGridNumberRow.ToString();
                }
            }
            else if ( !txtNumberOfRows.Text.Trim().Equals( string.Empty ) && !int.TryParse( txtNumberOfRows.Text, out numberOfRows ) )
            {
                Utils.ShowDialog( Resources.Messages.err_wrong_rows_number_pagination );
                Utils.AppendScript( "location.href='#codes';" );
                return;
            }
            else if ( txtNumberOfRows.Text.Trim().Equals( string.Empty ) )
            {
                gvCodelistsItem.PageSize = Utils.DetailsCodelistGridNumberRow;
                txtNumberOfRows.Text = Utils.DetailsCodelistGridNumberRow.ToString();
            }
            gvCodelistsItem.DataSource = lCodeListItem;
            gvCodelistsItem.DataBind();
            Utils.AppendScript( "location.href='#codes';" );
        }

        protected void gvCodelistsItem_RowDataBound(object sender, GridViewRowEventArgs e)
        {
           ICodelistMutableObject cl = GetCodeListFromSession();
           if ( e.Row.RowIndex != -1 )
           {
               string codeId = ((Label)e.Row.Cells[1].Controls[1]).Text;
               ICodeMutableObject code = cl.GetCodeById( codeId );
               Label lblNumber = (Label)e.Row.Cells[6].Controls[1];
               ImageButton btnImage = (ImageButton)e.Row.Cells[6].Controls[3];
               int numberOfAnnotation = code.Annotations.Where( ann => ( ann.Type != null && !ann.Type.Equals( "@ORDER@" ) ) || ann.Type == null ).Count();
               lblNumber.Text = numberOfAnnotation.ToString();
               if ( numberOfAnnotation == 0 && ( cl.FinalStructure.IsTrue || _action == Action.VIEW ) )
               {
                   btnImage.Enabled = false;
               }
           }
        }

        protected void btnAddNewCodeOnFinalStructure_Click(object sender, EventArgs e)
        {
        }

        protected void btnNewCodeOnFinalStructure_Click(object sender, EventArgs e)
        {
            string id = txt_id.Text;
            string agency = txtAgenciesReadOnly.Text;
            string[] tmpVersionParts = txt_version.Text.Split( '.' );
            bool[] versionsAvailable = { 
                                           tmpVersionParts.Length > 0, 
                                           tmpVersionParts.Length > 1,
                                           tmpVersionParts.Length > 2
                                       };
            int v1 = (versionsAvailable[0] ? Convert.ToInt32( tmpVersionParts[0] ) : 0 );
            int v2 = (versionsAvailable[1] ? Convert.ToInt32( tmpVersionParts[1] ) : 0 );
            int v3 = (versionsAvailable[2] ? Convert.ToInt32( tmpVersionParts[2] ) : 0 );

            EndPointElement epe = (EndPointElement)Session["CurrentEndPointObject"];
            WSClient wsClient = new WSClient(epe.IREndPoint);
            Service1SoapClient client = wsClient.GetClient();

            // Recupero l'id della codelist
            int foundCodelistId = 0, foundParentCodeId = 0, insertedCodeId = 0, foundLocalizedNameStringId = 0, foundLocalizedDescStringId = 0;
            client.GetCodelistId( id, agency, versionsAvailable[0], v1, versionsAvailable[1], v2, versionsAvailable[2], v3, ref foundCodelistId ); 

            string codeId = txt_id_new.Text.Trim(), parentCode = txt_parentid_new.Text.Trim(), codeOrder = txt_order_new.Text.Trim();

            #region CODE ID
            if ( !ValidationUtils.CheckIdFormat( codeId ) )
            {
                lblErrorOnNewInsert.Text = Resources.Messages.err_id_format;
                Utils.AppendScript( "openPopUp('df-Dimension', 600);" );
                Utils.AppendScript("location.href= '#codes';");
                return ;
            }

            #endregion

            #region CODE NAMES
            if ((AddTextName_new.TextObjectList == null) || (AddTextName_new.TextObjectList != null && AddTextName_new.TextObjectList.Count == 0 ) )
            {
                lblErrorOnNewInsert.Text = Resources.Messages.err_list_name_format;
                Utils.AppendScript( "openPopUp('df-Dimension', 600);" );
                Utils.AppendScript("location.href= '#codes';");
                return;
            }
            #endregion

            #region PARANT ID

            if ( codeId.Equals( parentCode ) )
            {
                lblErrorOnNewInsert.Text = Resources.Messages.err_parent_id_same_value;
                Utils.AppendScript( "openPopUp('df-Dimension-update', 600 );" );
                Utils.AppendScript("location.href= '#codes';");
                return;
            }

            #endregion

            #region CODE ORDER
            int tmpOrder = 0;
            if (!codeOrder.Equals(string.Empty) && !int.TryParse( codeOrder, out tmpOrder ) )
            {
                lblErrorOnNewInsert.Text = Resources.Messages.err_order_format_invalid;
                Utils.AppendScript( "openPopUp('df-Dimension', 600);" );
                Utils.AppendScript("location.href= '#codes';");
                return;
            }
            else
            {
                if ( tmpOrder < 0 )
                {
                    lblErrorOnNewInsert.Text = Resources.Messages.err_order_less_than_zero;
                    Utils.AppendScript( "openPopUp('df-Dimension', 600);" );
                    Utils.AppendScript("location.href= '#codes';");
                    return;
                }
            }
            #endregion

            if ( !client.GetDsdCodeId( foundCodelistId, parentCode, ref foundParentCodeId ) )
            {
                    lblErrorOnNewInsert.Text = Resources.Messages.err_while_retrieving_code;
                    Utils.AppendScript( "openPopUp('df-Dimension', 600);" );
                    Utils.AppendScript("location.href= '#codes';");
                    return;
            }

            if ( !client.InsertDsdCode( codeId, foundCodelistId.ToString(), foundParentCodeId, ref insertedCodeId ) )
            {
                    lblErrorOnNewInsert.Text = Resources.Messages.err_while_inserting_code;
                    Utils.AppendScript( "openPopUp('df-Dimension', 600);" );
                    Utils.AppendScript("location.href= '#codes';");
                    return;
            }
            if ( AddTextName_new.TextObjectList != null )
            {
                foreach ( var name in AddTextName_new.TextObjectList )
                {
                    if ( !client.InsertLocalizedString( insertedCodeId, name.Value, "Name", name.Locale, ref foundLocalizedNameStringId ) )
                    {
                        lblErrorOnNewInsert.Text = Resources.Messages.err_while_inserting_code_name;
                        Utils.AppendScript( "openPopUp('df-Dimension', 600);" );
                        Utils.AppendScript("location.href= '#codes';");
                        return;
                    }
                }
            }
            if ( AddTextDescription_new.TextObjectList != null )
            {
                foreach ( var desc in AddTextDescription_new.TextObjectList )
                {
                    if ( !client.InsertLocalizedString( insertedCodeId, desc.Value, "Desc", desc.Locale, ref foundLocalizedDescStringId ) )   
                    {
                        lblErrorOnNewInsert.Text = Resources.Messages.err_while_inserting_code_desc;
                        Utils.AppendScript( "openPopUp('df-Dimension', 600);" );
                        Utils.AppendScript("location.href= '#codes';");
                        return;
                    }
                }
            }

            txt_id_new.Text = string.Empty;
            txt_parentid_new.Text = string.Empty;
            AddTextDescription_new.ClearTextObjectListWithOutJS();
            AddTextName_new.ClearTextObjectListWithOutJS();

            WSModel wsModel = new WSModel();
            ISdmxObjects sdmxObject = wsModel.GetCodeList(_artIdentity, false,false);
            ICodelistObject cl = sdmxObject.Codelists.FirstOrDefault();
            Session[KEY_PAGE_SESSION] = cl.MutableInstance;

            BindData();
            Utils.AppendScript("location.href= '#codes';");
        }
    }

}