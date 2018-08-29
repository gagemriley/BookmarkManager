<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Landing.aspx.cs" Inherits="Landing" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>LCCC Enrollment Services Landing Page</title>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/png" href="https://png.icons8.com/ios/50/000000/web-design-filled.png" />

    <link rel="stylesheet" type="text/css" href="Styles/jquery-ui.css" />
    <link rel="stylesheet" type="text/css" href="Styles/jquery-ui.icon-font.css" />
    <link rel="stylesheet" type="text/css" href="Styles/theme.css" />
    <link rel="stylesheet" type="text/css" href="Styles/main.css" />
    <link rel="stylesheet" type="text/css" href="Styles/landingPage.css" />

    <script type="text/javascript" src="scripts/jQuery.js"></script>
    <script type="text/javascript" src="scripts/jQuery-ui.js"></script>
    <script type="text/javascript" src="scripts/testURL.js"></script>
    <script type="text/javascript" src="scripts/bookmarkFavicons.js"></script>
    <script type="text/javascript" src="scripts/landingButtons.js"></script>
    <script type="text/javascript" src="scripts/dialog.js"></script>
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
		<h1>Landing Page</h1>
		<div id="ribbonButtons">
			<asp:Button ID="ButtonAdmin" CssClass="themedButton primary-bg hoverable" runat="server" Text="Admin" OnClick="ButtonAdmin_Click" Visible="False" />
			<asp:Button ID="ButtonLogout" CssClass="themedButton primary-bg hoverable" runat="server" Text="Logout" OnClick="ButtonLogout_Click" />
		</div>
    </header>

    <div id="belownav">
        <div id="overlay"></div>

        <!-- Left pagelet -->
	    <!-- Contains common bookmarks and favorites -->
        <div class="pagelet left box-shadow primary-bg">
            <div class="sub-pagelet top">
                <h2>Common Tools</h2>
                <div id="common" class="content top secondary-bg">
                    <asp:GridView ID="GV_Tools" runat="server" AutoGenerateColumns="False" DataKeyNames="URL" DataSourceID="SqlDS_Tools" ShowHeader="False" Width="100%">
                        <Columns>
                            <asp:HyperLinkField DataNavigateUrlFields="URL" DataTextField="Name" ShowHeader="False" Target="_blank">
                            <ControlStyle CssClass="bookmark tertiary-bg hoverable" />
                            </asp:HyperLinkField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDS_Tools" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [TOOLS] ORDER BY [Name]" OldValuesParameterFormatString="original_{0}">
                    </asp:SqlDataSource>
                </div>
            </div>

            <div class="sub-pagelet bottom">
                <h2>Favorites</h2>
                <div class="buttons">
                    <button id="newFav" class="dialogButton">New Favorite</button>
                    <button id="editFav" class="dialogButton">Edit Favorites</button>
                </div>
                <div id="favs" class="content bottom secondary-bg">
                    <asp:UpdatePanel ID="UP_Favorites" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="GV_Favorites" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDS_Favorites" ShowHeader="False" Width="100%">
                                <Columns>
                                    <asp:HyperLinkField DataNavigateUrlFields="URL" DataTextField="Name" ShowHeader="False" Target="_blank">
                                    <ControlStyle CssClass="bookmark tertiary-bg hoverable" />
                                    </asp:HyperLinkField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDS_Favorites" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [USER_BOOKMARKS] WHERE (([UserID_FK] = ?) AND ([Type] = ?)) ORDER BY [Name], [URL]" ConflictDetection="CompareAllValues" DeleteCommand="DELETE FROM [USER_BOOKMARKS] WHERE [BookmarkID] = ? AND [UserID_FK] = ? AND [Name] = ? AND [URL] = ? AND [Type] = ?" InsertCommand="INSERT INTO [USER_BOOKMARKS] ([BookmarkID], [UserID_FK], [Name], [URL], [Type]) VALUES (?, ?, ?, ?, ?)" OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [USER_BOOKMARKS] SET [Name] = ?, [URL] = ?, [Type] = ? WHERE [BookmarkID] = ? AND [UserID_FK] = ? AND [Name] = ? AND [URL] = ? AND [Type] = ?">
                                <DeleteParameters>
                                    <asp:Parameter Name="original_BookmarkID" Type="Int32" />
                                    <asp:Parameter Name="original_UserID_FK" Type="Int32" />
                                    <asp:Parameter Name="original_Name" Type="String" />
                                    <asp:Parameter Name="original_URL" Type="String" />
                                    <asp:Parameter Name="original_Type" Type="Boolean" DefaultValue="True" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="BookmarkID" Type="Int32" />
                                    <asp:Parameter Name="UserID_FK" Type="Int32" />
                                    <asp:Parameter Name="Name" Type="String" />
                                    <asp:Parameter Name="URL" Type="String" />
                                    <asp:Parameter Name="Type" Type="Boolean" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:SessionParameter Name="UserID_FK" SessionField="userid" Type="Int32" />
                                    <asp:Parameter DefaultValue="True" Name="Type" Type="Boolean" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="Name" Type="String" />
                                    <asp:Parameter Name="URL" Type="String" />
                                    <asp:Parameter Name="Type" Type="Boolean" DefaultValue="True" />
                                    <asp:Parameter Name="original_BookmarkID" Type="Int32" />
                                    <asp:Parameter Name="original_UserID_FK" Type="Int32" />
                                    <asp:Parameter Name="original_Name" Type="String" />
                                    <asp:Parameter Name="original_URL" Type="String" />
                                    <asp:Parameter Name="original_Type" Type="Boolean" DefaultValue="True" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>

        </div>

        <!-- Center pagelet -->
	    <!-- Contains announcements -->
        <div class="pagelet center box-shadow primary-bg">
            <h2>Announcements</h2>
            <div id="announcements" class="content secondary-bg">
                <p>Coming soon!</p>
            </div>
        </div>

        <!-- Right pagelet -->
	    <!-- Contains policies & procedures and the document repository -->
        <div class="pagelet right box-shadow primary-bg">
            <div class="sub-pagelet top">
                <h2>Policies</h2>
                <div class="buttons">
                    <button id="newPolicy" class="dialogButton">New Policy</button>
                    <button id="editPolicy" class="dialogButton">Edit Policies</button>
                </div>

                <div id="policies" class="content top secondary-bg">
                    <asp:UpdatePanel ID="UP_Policies" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="GV_Policies" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDS_Policies" ShowHeader="False" Width="100%">
                                <Columns>
                                    <asp:HyperLinkField DataNavigateUrlFields="URL" DataTextField="Name" ShowHeader="False" Target="_blank">
                                    <ControlStyle CssClass="bookmark tertiary-bg hoverable" />
                                    </asp:HyperLinkField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDS_Policies" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [USER_BOOKMARKS] WHERE (([UserID_FK] = ?) AND ([Type] = ?)) ORDER BY [Name], [URL]" ConflictDetection="CompareAllValues" DeleteCommand="DELETE FROM [USER_BOOKMARKS] WHERE [BookmarkID] = ? AND [UserID_FK] = ? AND [Name] = ? AND [URL] = ? AND [Type] = ?" InsertCommand="INSERT INTO [USER_BOOKMARKS] ([BookmarkID], [UserID_FK], [Name], [URL], [Type]) VALUES (?, ?, ?, ?, ?)" OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [USER_BOOKMARKS] SET [Name] = ?, [URL] = ?, [Type] = ? WHERE [BookmarkID] = ? AND [UserID_FK] = ? AND [Name] = ? AND [URL] = ? AND [Type] = ?">
                                <DeleteParameters>
                                    <asp:Parameter Name="original_BookmarkID" Type="Int32" />
                                    <asp:Parameter Name="original_UserID_FK" Type="Int32" />
                                    <asp:Parameter Name="original_Name" Type="String" />
                                    <asp:Parameter Name="original_URL" Type="String" />
                                    <asp:Parameter Name="original_Type" Type="Boolean" DefaultValue="False" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="BookmarkID" Type="Int32" />
                                    <asp:Parameter Name="UserID_FK" Type="Int32" />
                                    <asp:Parameter Name="Name" Type="String" />
                                    <asp:Parameter Name="URL" Type="String" />
                                    <asp:Parameter Name="Type" Type="Boolean" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:SessionParameter Name="UserID_FK" SessionField="userid" Type="Int32" />
                                    <asp:Parameter DefaultValue="False" Name="Type" Type="Boolean" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="Name" Type="String" />
                                    <asp:Parameter Name="URL" Type="String" />
                                    <asp:Parameter Name="Type" Type="Boolean" DefaultValue="False" />
                                    <asp:Parameter Name="original_BookmarkID" Type="Int32" />
                                    <asp:Parameter Name="original_UserID_FK" Type="Int32" />
                                    <asp:Parameter Name="original_Name" Type="String" />
                                    <asp:Parameter Name="original_URL" Type="String" />
                                    <asp:Parameter Name="original_Type" Type="Boolean" DefaultValue="False"/>
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>

            <div class="sub-pagelet bottom">
                <h2>Documents</h2>
                <div id="docs" class="content bottom secondary-bg">
                    <asp:GridView ID="GV_Documents" runat="server" AutoGenerateColumns="False" DataKeyNames="URL" DataSourceID="SqlDS_Documents" ShowHeader="False" Width="100%">
                        <Columns>
                            <asp:HyperLinkField DataNavigateUrlFields="URL" DataTextField="Name" ShowHeader="False" Target="_blank">
                            <ControlStyle CssClass="bookmark tertiary-bg hoverable" />
                            </asp:HyperLinkField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDS_Documents" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [DOCUMENTS] ORDER BY [Name]">
                    </asp:SqlDataSource>
                </div>
            </div>
        </div>
    </div>

    
    <div id="newFavDialog" title="New Favorite" class="dialog">
        <asp:UpdatePanel ID="UP_NewFav" runat="server">
            <ContentTemplate>
                <table>
                    <tbody>
                        <tr>
                            <td><asp:Label ID="LabelFavName" runat="server" Text="Display Name:" /></td>
                            <td><asp:TextBox ID="TextBoxFavName" runat="server" /></td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="LabelFavURL" runat="server" Text="URL:" /></td>
                            <td><asp:TextBox ID="TextBoxFavURL" runat="server" Text="https://" CssClass="url" /></td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr class="tertiary-bg">
                            <td><asp:Button ID="ButtonAddFavorite" runat="server" Text="Add Favorite" OnClick="ButtonAddFavorite_Click" CssClass="themedButton" /></td>
                            <td><asp:Label ID="LabelSubmitErrorFav" runat="server" Text="" ForeColor="Red" CssClass="errorMsg" /></td>
                        </tr>
                    </tfoot>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
	<div id="editFavDialog" title="Edit Favorites" class="dialog">
        <asp:UpdatePanel ID="UP_EditFav" runat="server">
            <ContentTemplate>
		        <asp:GridView ID="GV_EditFav" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDS_Favorites" ShowHeader="False" Width="100%" DataKeyNames="BookmarkID,UserID_FK">
                    <Columns>
                        <asp:BoundField DataField="BookmarkID" ReadOnly="True" SortExpression="BookmarkID" Visible="False" />
                        <asp:BoundField DataField="UserID_FK" ReadOnly="True" SortExpression="UserID_FK" Visible="False" />
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        <asp:BoundField DataField="URL" HeaderText="URL" SortExpression="URL" />
                        <asp:CommandField ButtonType="Button" ShowEditButton="True" ShowDeleteButton="True">
                        <ControlStyle CssClass="themedButton" />
                        </asp:CommandField>
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
	</div>
    <div id="newPolicyDialog" title="New Policy" class="dialog">
        <asp:UpdatePanel ID="UP_NewPolicy" runat="server">
            <ContentTemplate>
                <table>
                    <tbody>
                        <tr>
                            <td><asp:Label ID="LabelPolicyName" runat="server" Text="Display Name:" /></td>
                            <td><asp:TextBox ID="TextBoxPolicyName" runat="server" /></td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="LabelPolicyURL" runat="server" Text="URL:" /></td>
                            <td><asp:TextBox ID="TextBoxPolicyURL" runat="server" Text="https://" CssClass="url" /></td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr class="tertiary-bg">
                            <td><asp:Button ID="ButtonAddPolicy" runat="server" Text="Add Policy" OnClick="ButtonAddPolicy_Click" CssClass="themedButton" /></td>
                            <td><asp:Label ID="LabelSubmitErrorPolicy" runat="server" Text="" ForeColor="Red" CssClass="errorMsg" /></td>
                        </tr>
                    </tfoot>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
	<div id="editPolicyDialog" title="Edit Policies" class="dialog">
		<asp:UpdatePanel ID="UP_EditPolicy" runat="server">
            <ContentTemplate>
		        <asp:GridView ID="GV_EditPolicy" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDS_Policies" ShowHeader="False" Width="100%" DataKeyNames="BookmarkID,UserID_FK">
                    <Columns>
                        <asp:BoundField DataField="BookmarkID" ReadOnly="True" SortExpression="BookmarkID" Visible="False" />
                        <asp:BoundField DataField="UserID_FK" ReadOnly="True" SortExpression="UserID_FK" Visible="False" />
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        <asp:BoundField DataField="URL" HeaderText="URL" SortExpression="URL" />
                        <asp:CommandField ButtonType="Button" ShowEditButton="True" ShowDeleteButton="True">
                        <ControlStyle CssClass="themedButton" />
                        </asp:CommandField>
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
	</div>

    </form>
</body>
</html>
