﻿<%@ Page Title="" Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true"
    CodeBehind="HclItemDetails.aspx.cs" Inherits="ISTATRegistry.HclItemDetails" EnableSessionState="True" %>

<%@ Register Src="UserControls/FileDownload3.ascx" TagName="FileDownload3" TagPrefix="uc1" %>
<%@ Register Src="UserControls/AddText.ascx" TagName="AddText" TagPrefix="uc2" %>
<%@ Register Src="~/UserControls/ControlAnnotations.ascx" TagName="ControlAnnotations"
    TagPrefix="uc4" %>
<%@ Register Src="UserControls/SearchBar.ascx" TagName="SearchBar" TagPrefix="uc5" %>
<%@ Register Src="UserControls/DuplicateArtefact.ascx" TagName="DuplicateArtefact"
    TagPrefix="uc7" %>
<%@ Register Src="UserControls/GetCodeList.ascx" TagName="GetCodeList" TagPrefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#tab-container').easytabs();

            $(".datepicker").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd/mm/yy'
            });

            $(".datepicker").datepicker("option", "showAnim", "drop");
        });

        jQuery(function ($) {
            var form = $('form'), oldSubmit = form[0].onsubmit;
            form[0].onsubmit = null;

            $('form').submit(function () {
                // reset the onbeforeunload
                window.onbeforeunload = null;

                // run what actually was on
                if (oldSubmit)
                    oldSubmit.call(this);
            });
        });

        $(window).bind('beforeunload', function (e) {
            var confirmationMessage = "<%=Resources.Messages.lbl_question_exit_page %>";  // a space
            (e || window.event).returnValue = confirmationMessage;
            return confirmationMessage;
        }); 


    </script>
    <style type="text/css">
        .etabs { margin: 0; padding: 0; }
        .tab { display: inline-block; zoom:1; *display:inline; background: #eee; border: solid 1px #999; border-bottom: none; -moz-border-radius: 4px 4px 0 0; -webkit-border-radius: 4px 4px 0 0; }
        
        .tab a { font-size: 14px; line-height: 2em; display: block; padding: 0 10px; outline: none; color: #000000; text-decoration: none}
        .tab a:hover { color: #ff0000; text-decoration: none }
        .tab.active { background: #fff; padding-top: 6px; position: relative; top: 1px; border-color: #666; color: #000000; text-decoration: none}
        .tab a.active { font-weight: bold; color: #000000; text-decoration: none}
        
        .tab-container .panel-container { background: #fff; border: solid #666 1px; padding: 10px; -moz-border-radius: 0 4px 4px 4px; -webkit-border-radius: 0 4px 4px 4px; }
        
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="lblHclDetail" runat="server" CssClass="PageTitle"><%= Resources.Messages.lbl_hcl%></asp:Label>
    <div id="divBack">
        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Hcl.aspx?m=y" ImageUrl="~/images/back.png"><%= Resources.Messages.lbl_back %></asp:HyperLink>
    </div>
    <hr style="width: 100%" />
    <div id="tab-container" class='tab-container'>
        <ul class='etabs'>
            <li class='tab'><a href="#general">
                <%= Resources.Messages.lbl_general %></a></li>
            <li class='tab'><a href="#hierarchy">
                <%= Resources.Messages.lbl_hierarchy%></a></li>
        </ul>
        <div class='panel-container'>
            <div id="general">
                <table class="tableForm">
                    <tr>
                        <td>
                            <asp:Label ID="lblHclID" runat="server" Text="<%$ Resources:Messages, lbl_id %>"
                                CssClass="tdProperty"></asp:Label>
                        </td>
                        <td width="45%">
                            <asp:TextBox ID="txtHclID" runat="server" Enabled="false" ValidationGroup="dsd"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="lblAgency" runat="server" Text="<%$ Resources:Messages, lbl_agency%>"
                                CssClass="tdProperty"></asp:Label>
                        </td>
                        <td width="45%">
                            <asp:DropDownList ID="cmbAgencies" runat="server" Enabled="false">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblVersion" runat="server" Text="<%$ Resources:Messages, lbl_version%>"
                                CssClass="tdProperty"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtVersion" runat="server" Enabled="false" ValidationGroup="dsd"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="lblIsFinal" runat="server" Text="<%$ Resources:Messages, lbl_is_final%>"
                                CssClass="tdProperty"></asp:Label>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkIsFinal" runat="server" Enabled="false" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblURI" runat="server" Text="<%$ Resources:Messages, lbl_uri%>" CssClass="tdProperty"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtURI" runat="server" Enabled="false"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="lblURN" runat="server" Text="<%$ Resources:Messages, lbl_urn%>" CssClass="tdProperty"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtURN" runat="server" Enabled="false"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblValidFrom" runat="server" Text="<%$ Resources:Messages, lbl_valid_from%>"
                                CssClass="tdProperty"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtValidFrom" runat="server" Enabled="false" ValidationGroup="dsd"
                                CssClass="datepicker"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="lblValidTo" runat="server" Text="<%$ Resources:Messages, lbl_valid_to%>"
                                CssClass="tdProperty"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtValidTo" runat="server" Enabled="false" ValidationGroup="dsd"
                                CssClass="datepicker"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblHclNames" runat="server" Text="<%$ Resources:Messages, lbl_name%>"
                                CssClass="tdProperty"></asp:Label>
                        </td>
                        <td>
                            <asp:Panel ID="pnlViewName" runat="server" Visible="false">
                                <asp:TextBox ID="txtHclName" runat="server" Enabled="false" TextMode="MultiLine"
                                    Rows="5" ValidationGroup="dsd" CssClass="noScalableTextArea"></asp:TextBox>
                            </asp:Panel>
                            <asp:Panel ID="pnlEditName" runat="server" Visible="false">
                                <uc2:AddText ID="AddTextName" runat="server" />
                            </asp:Panel>
                        </td>
                        <td>
                            <asp:Label ID="lblHclDescriptions" runat="server" Text="<%$ Resources:Messages, lbl_description%>"
                                CssClass="tdProperty"></asp:Label>
                        </td>
                        <td>
                            <asp:Panel ID="pnlViewDescription" runat="server" Visible="false">
                                <asp:TextBox ID="txtHclDescription" runat="server" Enabled="false" TextMode="MultiLine"
                                    Rows="5" CssClass="noScalableTextArea"></asp:TextBox>
                            </asp:Panel>
                            <asp:Panel ID="pnlEditDescription" runat="server" Visible="false">
                                <uc2:AddText ID="AddTextDescription" runat="server" />
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbl_annotation" runat="server" Text="<%$ Resources:Messages, lbl_annotation%>"
                                CssClass="tdProperty"></asp:Label>
                        </td>
                        <td colspan="3">
                            <asp:Panel ID="pnlAnnotation" runat="server" Visible="true">
                                <uc4:ControlAnnotations ID="AnnotationGeneral" runat="server" />
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="hierarchy">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <fieldset>
                            <legend>
                                <asp:Literal ID="Literal1" runat="server" Text="<%$ Resources:Messages, lbl_included_codelist%>" /></legend>
                            <table class="tableForm">
                                <tr>
                                    <td colspan="2">
                                        <asp:GridView ID="gvIncludedCodelist" runat="server" CssClass="Grid" AllowPaging="True"
                                            PagerSettings-Mode="NumericFirstLast" PagerSettings-FirstPageText="<%# Resources.Messages.btn_goto_first %>"
                                            PagerSettings-LastPageText="<%# Resources.Messages.btn_goto_last %>" AutoGenerateColumns="False"
                                            PagerSettings-Position="TopAndBottom" OnRowCommand="gvIncludedCodelist_RowCommand"
                                            OnRowDeleting="gvIncludedCodelist_RowDeleting">
                                            <Columns>
                                                <asp:TemplateField HeaderText="ID" SortExpression="ID">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblID" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="190px" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Agency" SortExpression="Agency">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAgency" runat="server" Text='<%# Bind("Agency") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="70px" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Version" SortExpression="Version">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblVersion" runat="server" Text='<%# Bind("Version") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="50px" />
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="LocalID" HeaderText="LocalID" SortExpression="LocalID"
                                                    Visible="False" />
                                                <asp:TemplateField HeaderText="" ShowHeader="False">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="btnDelete" runat="server" CausesValidation="False" CommandName="Delete"
                                                            CommandArgument="<%# Container.DataItemIndex %>" ImageUrl="~/images/delete2.png"
                                                            ToolTip="Delete" />
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="50px" HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="" ShowHeader="False">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="btnDetails" runat="server" CausesValidation="False" CommandName="Details"
                                                            CommandArgument="<%# Container.DataItemIndex %>" ImageUrl="~/images/Details2.png"
                                                            ToolTip="View details" />
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="50px" HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                            </Columns>
                                            <HeaderStyle CssClass="hs" />
                                            <RowStyle CssClass="rs" />
                                            <AlternatingRowStyle CssClass="ars" />
                                            <PagerStyle CssClass="pgr"></PagerStyle>
                                        </asp:GridView>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <uc3:GetCodeList ID="GetCodeList1" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <fieldset>
                            <legend>Qualcosa....</legend>
                            <table style="width: 100%">
                                <tr>
                                    <td style="width: 50%">
                                        <asp:Label ID="lblCLSelected" runat="server" Text=""></asp:Label>
                                        <asp:GridView ID="gvCodes" runat="server" CssClass="Grid" AllowPaging="True" PagerSettings-Mode="NumericFirstLast"
                                            PagerSettings-FirstPageText="<%# Resources.Messages.btn_goto_first %>" PagerSettings-LastPageText="<%# Resources.Messages.btn_goto_last %>"
                                            AutoGenerateColumns="False" PagerSettings-Position="Bottom" OnRowCommand="gvCodes_RowCommand"
                                            OnPageIndexChanging="gvCodes_PageIndexChanging" OnRowDataBound="gvCodes_RowDataBound">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Code" SortExpression="Id">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCode" runat="server" Text='<%# Bind("Id") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="190px" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="" ShowHeader="False">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="btnAddToHcl" runat="server" CausesValidation="False" CommandName="AddToHcl"
                                                            CommandArgument="<%# Container.DataItemIndex %>" ImageUrl="~/images/Details2.png"
                                                            ToolTip="Add to Hcl" />
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="50px" HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                            </Columns>
                                            <HeaderStyle CssClass="hs" />
                                            <RowStyle CssClass="rs" />
                                            <AlternatingRowStyle CssClass="ars" />
                                            <PagerStyle CssClass="pgr"></PagerStyle>
                                        </asp:GridView>
                                    </td>
                                    <td style="width: 50%">
                                        <asp:TreeView ID="TreeView1" runat="server" OnSelectedNodeChanged="TreeView1_SelectedNodeChanged"
                                            AutoGenerateDataBindings="False" ShowLines="True">
                                            <SelectedNodeStyle BackColor="#FFCC99" />
                                        </asp:TreeView>
                                        <asp:HiddenField ID="hdnCopiedNode" runat="server" />
                                        <br />
                                        <asp:TextBox ID="TextBox1" runat="server" Style="width: 128px"></asp:TextBox>
                                        <asp:TextBox ID="TextBox2" runat="server" Style="width: 128px"></asp:TextBox>
                                        <br />
                                        <asp:Button ID="btnAdd" runat="server" OnClick="btnAdd_Click" Text="Add" />
                                        &nbsp;<asp:Button ID="btnDelete" runat="server" OnClick="btnDelete_Click" Text="Delete" />
                                        &nbsp;<asp:Button ID="btnCut" runat="server" OnClick="btnCut_Click" Text="Cut" />
                                        &nbsp;<asp:Button ID="btnPaste" runat="server" OnClick="btnPaste_Click" Text="Paste" />
                                        &nbsp;<asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="Cancel" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
        <asp:Button ID="btnSaveHcl" runat="server" Text="<%$ Resources:Messages, btn_save%>"
            OnClick="btnSaveHcl_Click" Visible="false" />
        <div style="float: right">
            <uc1:FileDownload3 ID="FileDownload31" runat="server" />
        </div>
        <uc7:DuplicateArtefact ID="DuplicateArtefact1" runat="server" Visible="false" />
        <br />
</asp:Content>
