﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GetDSD.ascx.cs" Inherits="ISTATRegistry.UserControls.GetDSD" %>
<%@ Register Src="SearchBar.ascx" TagName="SearchBar" TagPrefix="uc1" %>
<a href='javascript: openP("df_dsd<%=ControlID %>",<%=PopUpWidth %>)' title="<%= Resources.Messages.lbl_key_family %>">
    <img src="./images/<%=IconFileName %>" border="0" alt="<%= Resources.Messages.lbl_key_family %>" />
</a>
<div id="df_dsd<%=ControlID %>" class="popup_block">
    <asp:Label ID="lblTitle" runat="server" Text="<%$ Resources:Messages, lbl_select_keyfamily %>"
        CssClass="PageTitle"></asp:Label>
    <hr style="width: 100%;" />
    <uc1:SearchBar ID="SearchBar1" runat="server" />
    <asp:GridView ID="gvDSD" runat="server" AllowPaging="True" CssClass="Grid" OnPageIndexChanging="gvDSD_PageIndexChanging"
        AutoGenerateColumns="False" OnRowCommand="gvDSD_RowCommand" OnSelectedIndexChanged="gvDSD_SelectedIndexChanged"
        PagerSettings-Mode="NumericFirstLast" PagerSettings-FirstPageText="<%# Resources.Messages.btn_goto_first %>"
        PagerSettings-LastPageText="<%# Resources.Messages.btn_goto_last %>">
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
            <asp:TemplateField HeaderText="Name" SortExpression="Name">
                <ItemTemplate>
                    <asp:Label ID="lblName" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle Width="310px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="IsFinal" SortExpression="IsFinal">
                <ItemTemplate>
                    <asp:CheckBox ID="chkIsFinal" runat="server" Enabled="false" Checked='<%# Bind("IsFinal") %>' />
                </ItemTemplate>
                <HeaderStyle Width="50px" />
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select" Text="<%# Resources.Messages.lbl_select %>"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <HeaderStyle CssClass="hs" />
        <RowStyle CssClass="rs" />
        <AlternatingRowStyle CssClass="ars" />
        <PagerStyle CssClass="pgr"></PagerStyle>
    </asp:GridView>
</div>
