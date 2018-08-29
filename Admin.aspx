<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Admin.aspx.cs" Inherits="Admin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>LCCC Enrollment Services Admin Page</title>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/png" href="https://png.icons8.com/ios/50/000000/web-design-filled.png" />

    <link rel="stylesheet" type="text/css" href="Styles/jquery-ui.css" />
    <link rel="stylesheet" type="text/css" href="Styles/jquery-ui.icon-font.css" />
    <link rel="stylesheet" type="text/css" href="Styles/theme.css" />
    <link rel="stylesheet" type="text/css" href="Styles/main.css" />
    <link rel="stylesheet" type="text/css" href="Styles/admin/admin.css" />
    <link rel="stylesheet" type="text/css" href="Styles/richText.css" />

    <script type="text/javascript" src="scripts/jQuery.js"></script>
    <script type="text/javascript" src="scripts/jQuery-ui.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("div#tabs").tabs();
            $("div#tabs").tabs("disable", 2);
        });
    </script>
    <script type="text/javascript" src="scripts/dialog.js"></script>
    <script type="text/javascript" src="scripts/richTextEditor.js"></script>
</head>
<body class="main-bg">
    <form id="form1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <!-- Header ribbon -->
    <header class="box-shadow tertiary-bg">
		<div id="lccc-home">
            <a href="https://www.lorainccc.edu" target="_blank">
			    <img src="Styles/images/LCCC-Logo.png" alt="Lorain County Community College Logo" />
            </a>
		</div>
		<h1>Admin Page</h1>
		<div id="ribbonButtons">
			<asp:Button ID="ButtonLanding" CssClass="themedButton primary-bg hoverable" runat="server" Text="Landing" OnClick="ButtonLanding_Click"/>
			<asp:Button ID="ButtonLogout" CssClass="themedButton primary-bg hoverable" runat="server" Text="Logout" OnClick="ButtonLogout_Click" />
		</div>
    </header>

    <div id="belownav">
    <div id="overlay"></div>
    <div id="tabs" class="box-shadow">

        <ul>
            <li><a href="#tab-0">Users</a></li>
		    <li><a href="#tab-1">Common Tools</a></li>
		    <li><a href="#tab-2">Announcements</a></li>
		    <li><a href="#tab-3">Documents</a></li>
        </ul>

        <div id="tab-0">
            <asp:UpdatePanel ID="UP_Users" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="GV_Users" runat="server" AutoGenerateColumns="False" DataKeyNames="UserID" DataSourceID="SqlDS_Users" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" GridLines="Vertical" ForeColor="Black" Width="100%">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:CommandField ButtonType="Button" ShowEditButton="True">
                            <ControlStyle CssClass="themedButton" />
                            </asp:CommandField>
                            <asp:BoundField DataField="UserFirstName" HeaderText="First Name" SortExpression="UserFirstName" />
                            <asp:BoundField DataField="UserLastName" HeaderText="Last Name" SortExpression="UserLastName" />
                            <asp:BoundField DataField="UserEmail" HeaderText="Email" SortExpression="UserEmail" />
                            <asp:CheckBoxField DataField="Admin" HeaderText="Admin" SortExpression="Admin" ReadOnly="True" />
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:Button ID="DeleteUser" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="javascript:return landingPageApp_ns.common_ns.confirmDialog('Confirm Delete', 'Are you sure you want to delete this user? This will also delete all their bookmarks.', 'Deleted data cannot be recovered!', this.name, '');" />
                                </ItemTemplate>
                                <ControlStyle CssClass="themedButton" />
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#CCCC99" />
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                        <RowStyle BackColor="#F7F7DE" />
                        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#FBFBF2" />
                        <SortedAscendingHeaderStyle BackColor="#848384" />
                        <SortedDescendingCellStyle BackColor="#EAEAD3" />
                        <SortedDescendingHeaderStyle BackColor="#575357" />
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:SqlDataSource ID="SqlDS_Users" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [USERS] ORDER BY [UserLastName], [UserFirstName]" OldValuesParameterFormatString="original_{0}" ConflictDetection="CompareAllValues" DeleteCommand="DELETE FROM [USERS] WHERE [UserID] = ? AND [UserFirstName] = ? AND [UserLastName] = ? AND [UserEmail] = ? AND [Admin] = ?" InsertCommand="INSERT INTO [USERS] ([UserID], [UserFirstName], [UserLastName], [UserPassword], [UserEmail], [Admin]) VALUES (?, ?, ?, ?, ?, ?)" UpdateCommand="UPDATE [USERS] SET [UserFirstName] = ?, [UserLastName] = ?, [UserEmail] = ? WHERE [UserID] = ?">
                <DeleteParameters>
                    <asp:Parameter Name="original_UserID" Type="Int32" />
                    <asp:Parameter Name="original_UserFirstName" Type="String" />
                    <asp:Parameter Name="original_UserLastName" Type="String" />
                    <asp:Parameter Name="original_UserEmail" Type="String" />
                    <asp:Parameter Name="original_Admin" Type="Boolean" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="UserID" Type="Int32" />
                    <asp:Parameter Name="UserFirstName" Type="String" />
                    <asp:Parameter Name="UserLastName" Type="String" />
                    <asp:Parameter Name="UserPassword" Type="String" />
                    <asp:Parameter Name="UserEmail" Type="String" />
                    <asp:Parameter Name="Admin" Type="Boolean" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="UserFirstName" Type="String" />
                    <asp:Parameter Name="UserLastName" Type="String" />
                    <asp:Parameter Name="UserEmail" Type="String" />
                    <asp:Parameter Name="original_UserID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <div class="tableFooter tertiary-bg">
                <button id="addUser" class="themedButton dialogButton">Add User</button>
                <button id="changePassword" class="themedButton dialogButton">Change Password</button>
            </div>
        </div>

        <div id="tab-1">
            <asp:UpdatePanel ID="UP_Tools" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="GV_Tools" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="ToolID" DataSourceID="SqlDS_Tools" GridLines="Vertical" ForeColor="Black" Width="100%">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:CommandField ButtonType="Button" ShowEditButton="True">
                            <ControlStyle CssClass="themedButton" />
                            </asp:CommandField>
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="URL" HeaderText="URL" SortExpression="URL" />
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:Button ID="DeleteTool" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="javascript:return landingPageApp_ns.common_ns.confirmDialog('Confirm Delete', 'Are you sure you want to delete this link? This will affect all users.', 'Deleted data cannot be recovered!', this.name, '');" />
                                </ItemTemplate>
                                <ControlStyle CssClass="themedButton" />
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#CCCC99" />
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                        <RowStyle BackColor="#F7F7DE" />
                        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#FBFBF2" />
                        <SortedAscendingHeaderStyle BackColor="#848384" />
                        <SortedDescendingCellStyle BackColor="#EAEAD3" />
                        <SortedDescendingHeaderStyle BackColor="#575357" />
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:SqlDataSource ID="SqlDS_Tools" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [TOOLS] WHERE [ToolID] = ? AND [Name] = ? AND [URL] = ?" InsertCommand="INSERT INTO [TOOLS] ([ToolID], [Name], [URL]) VALUES (?, ?, ?)" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [TOOLS] ORDER BY [Name], [URL]" UpdateCommand="UPDATE [TOOLS] SET [Name] = ?, [URL] = ? WHERE [ToolID] = ? AND [Name] = ? AND [URL] = ?" ConflictDetection="CompareAllValues" OldValuesParameterFormatString="original_{0}">
                <DeleteParameters>
                    <asp:Parameter Name="original_ToolID" Type="Int32" />
                    <asp:Parameter Name="original_Name" Type="String" />
                    <asp:Parameter Name="original_URL" Type="String" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ToolID" Type="Int32" />
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="URL" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="URL" Type="String" />
                    <asp:Parameter Name="original_ToolID" Type="Int32" />
                    <asp:Parameter Name="original_Name" Type="String" />
                    <asp:Parameter Name="original_URL" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <div class="tableFooter tertiary-bg">
                <button id="addTool" class="themedButton dialogButton">Add Tool</button>
            </div>
        </div>

        <div id="tab-2">
            <asp:UpdatePanel ID="UP_Announcements" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="GV_Announcements" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataSourceID="SqlDS_Announcements" ForeColor="Black" GridLines="Vertical" Width="100%" DataKeyNames="DocumentID">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="URL" HeaderText="URL" SortExpression="URL" />
                        </Columns>
                        <FooterStyle BackColor="#CCCC99" />
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                        <RowStyle BackColor="#F7F7DE" />
                        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#FBFBF2" />
                        <SortedAscendingHeaderStyle BackColor="#848384" />
                        <SortedDescendingCellStyle BackColor="#EAEAD3" />
                        <SortedDescendingHeaderStyle BackColor="#575357" />
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:SqlDataSource ID="SqlDS_Announcements" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [DOCUMENTS]">
            </asp:SqlDataSource>
            <div class="tableFooter tertiary-bg">
                <button id="addPost" class="themedButton dialogButton">Add Announcement</button>
            </div>
        </div>

        <div id="tab-3">
            <asp:UpdatePanel ID="UP_Documents" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="GV_Documents" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="DocumentID" DataSourceID="SqlDS_Documents" ForeColor="Black" GridLines="Vertical" Width="100%">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:CommandField ShowEditButton="True" ButtonType="Button">
                            <ControlStyle CssClass="themedButton" />
                            </asp:CommandField>
                            <asp:BoundField DataField="DocumentID" ReadOnly="True" SortExpression="DocumentID" Visible="False" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="URL" HeaderText="URL" SortExpression="URL" />
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:Button ID="DeleteDocument" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="javascript:return landingPageApp_ns.common_ns.confirmDialog('Confirm Delete', 'Are you sure you want to delete this document link? This will not delete the document itself, but it will no longer appear on any user landing page.', 'Deleted data cannot be recovered!', this.name, '');" />
                                </ItemTemplate>
                                <ControlStyle CssClass="themedButton" />
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#CCCC99" />
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                        <RowStyle BackColor="#F7F7DE" />
                        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#FBFBF2" />
                        <SortedAscendingHeaderStyle BackColor="#848384" />
                        <SortedDescendingCellStyle BackColor="#EAEAD3" />
                        <SortedDescendingHeaderStyle BackColor="#575357" />
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:SqlDataSource ID="SqlDS_Documents" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [DOCUMENTS] WHERE [DocumentID] = ? AND [Name] = ? AND [URL] = ?" InsertCommand="INSERT INTO [DOCUMENTS] ([DocumentID], [Name], [URL]) VALUES (?, ?, ?)" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [DOCUMENTS] ORDER BY [Name], [URL]" UpdateCommand="UPDATE [DOCUMENTS] SET [Name] = ?, [URL] = ? WHERE [DocumentID] = ?" ConflictDetection="CompareAllValues" OldValuesParameterFormatString="original_{0}">
                <DeleteParameters>
                    <asp:Parameter Name="original_DocumentID" Type="Int32" />
                    <asp:Parameter Name="original_Name" Type="String" />
                    <asp:Parameter Name="original_URL" Type="String" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="DocumentID" Type="Int32" />
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="URL" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="URL" Type="String" />
                    <asp:Parameter Name="original_DocumentID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <div class="tableFooter tertiary-bg">
                <button id="addDoc" class="themedButton dialogButton">Add Document</button>
            </div>
        </div>

    </div>
    </div>

    <div id="addUserDialog" title="Add User" class="dialog">
        <asp:UpdatePanel ID="UP_AddUser" runat="server">
            <ContentTemplate>
                <table>
                    <tbody>
                        <tr>
                            <td><asp:Label ID="LabelFname" runat="server" Text="First Name:" /></td>
                            <td><asp:TextBox ID="TextBoxFname" runat="server" /></td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="LabelLname" runat="server" Text="Last Name:" /></td>
                            <td><asp:TextBox ID="TextBoxLname" runat="server" /></td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="LabelPassword" runat="server" Text="Password:" /></td>
                            <td><asp:TextBox ID="TextBoxPassword" runat="server" TextMode="Password" /></td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="LabelConfirmPassword" runat="server" Text="Confirm Password:" /></td>
                            <td><asp:TextBox ID="TextBoxConfirmPassword" runat="server" TextMode="Password" /></td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="LabelEmail" runat="server" Text="Email Address:" /></td>
                            <td><asp:TextBox ID="TextBoxEmail" runat="server" TextMode="Email" /></td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="LabelAdmin" runat="server" Text="Is Administrator:" /></td>
                            <td><asp:CheckBox ID="CheckBoxAdmin" runat="server" /></td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr class="tertiary-bg">
                            <td><asp:Button ID="ButtonAddUser" runat="server" Text="Add User" OnClick="ButtonAddUser_Click" CssClass="themedButton" /></td>
                            <td><asp:Label ID="LabelSubmitErrorUser" runat="server" Text="" ForeColor="Red" /></td>
                        </tr>
                    </tfoot>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div id="changePasswordDialog" title="Change Password" class="dialog">
        <asp:UpdatePanel ID="UP_ChangePassword" runat="server">
            <ContentTemplate>
                <table>
                    <tbody>
                        <tr>
                            <td><asp:Label ID="LabelDDChgPassword" runat="server" Text="User:" /></td>
                            <td><asp:DropDownList ID="DropDownChgPassword" runat="server" EnableViewState="True" DataSourceID="SqlDS_FullName" DataTextField="FullName" DataValueField="UserID" /></td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="LabelChgPassword" runat="server" Text="New Password:" /></td>
                            <td><asp:TextBox ID="TextBoxChgPassword" runat="server" TextMode="Password" /></td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="LabelChgConfirmPassword" runat="server" Text="Confirm Password:" /></td>
                            <td><asp:TextBox ID="TextBoxChgConfirmPassword" runat="server" TextMode="Password" /></td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr class="tertiary-bg">
                            <td><asp:Button ID="ButtonChangePassword" runat="server" Text="Change Password" OnClick="ButtonChangePassword_Click" CssClass="themedButton" /></td>
                            <td><asp:Label ID="LabelSubmitErrorChgPassword" runat="server" Text="" ForeColor="Red" /></td>
                        </tr>
                    </tfoot>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:SqlDataSource ID="SqlDS_FullName" runat="server" SelectCommand="SELECT * FROM [Q_UserFullName] ORDER BY [UserID]" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" />
    </div>
	<div id="addToolDialog" title="Add Tool" class="dialog">
		<asp:UpdatePanel ID="UP_AddTool" runat="server">
            <ContentTemplate>
                <table>
                    <tbody>
                        <tr>
                            <td><asp:Label ID="LabelToolName" runat="server" Text="Display Name:" /></td>
                            <td><asp:TextBox ID="TextBoxToolName" runat="server" /></td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="LabelToolURL" runat="server" Text="URL:" /></td>
                            <td><asp:TextBox ID="TextBoxToolURL" runat="server" Text="https://" CssClass="url" /></td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr class="tertiary-bg">
                            <td><asp:Button ID="ButtonAddTool" runat="server" Text="Add Tool" OnClick="ButtonAddTool_Click" CssClass="themedButton" /></td>
                            <td><asp:Label ID="LabelSubmitErrorTool" runat="server" Text="" ForeColor="Red" /></td>
                        </tr>
                    </tfoot>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
	</div>
	<div id="addPostDialog" title="Add Announcement" class="dialog">
        <asp:UpdatePanel ID="UP_AddPost" runat="server">
            <ContentTemplate>
		        <div id="richTextEditor">
                    <ul class="toolbar">
                        <li><button class="richText-button" title="Bold"><span class="richText-bold">B</span></button></li>
                        <li><button class="richText-button" title="Italic"><span class="richText-italic">I</span></button></li>
                        <li><button class="richText-button" title="Underline"><span class="richText-underline">U</span></button></li>
                    </ul>
                    <asp:TextBox ID="TextBoxPost" runat="server" TextMode="MultiLine" Columns="50" Rows="8" Width="100%" autofocus />
		        </div>
            </ContentTemplate>
        </asp:UpdatePanel>
	</div>
	<div id="addDocDialog" title="Add Document" class="dialog">
		<asp:UpdatePanel ID="UP_AddDoc" runat="server">
            <ContentTemplate>
                <table>
                    <tbody>
                        <tr>
                            <td><asp:Label ID="LabelDocName" runat="server" Text="Display Name:" /></td>
                            <td><asp:TextBox ID="TextBoxDocName" runat="server" /></td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="LabelDocURL" runat="server" Text="URL:" /></td>
                            <td><asp:TextBox ID="TextBoxDocURL" runat="server" Text="https://" CssClass="url" /></td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr class="tertiary-bg">
                            <td><asp:Button ID="ButtonAddDoc" runat="server" Text="Add Document" OnClick="ButtonAddDoc_Click" CssClass="themedButton" /></td>
                            <td><asp:Label ID="LabelSubmitErrorDoc" runat="server" Text="" ForeColor="Red" /></td>
                        </tr>
                    </tfoot>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
	</div>
    <div id="confirmDialog" class="dialog">
        <p class="message"></p>
        <p class="warning"><b></b></p>
    </div>

    </form>
</body>
</html>
