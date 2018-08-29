<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Enrollment Services Landing Page</title>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/png" href="https://png.icons8.com/ios/50/000000/web-design-filled.png" />

	<link rel="stylesheet" type="text/css" href="Styles/theme.css" />
	<link rel="stylesheet" type="text/css" href="Styles/main.css" />
	<link rel="stylesheet" type="text/css" href="Styles/login.css" />
</head>
<body>
    <form id="form1" runat="server">
    <header class="box-shadow tertiary-bg">
		<div id="lccc-home">
			<img src="Styles/images/LCCC-Logo.png" alt="Lorain County Community College Logo" />
		</div>
		<h1>Login</h1>
    </header>
        <div id="belownav">
            <table id="login">
                <tbody>
                    <tr>
                        <td><asp:Label ID="LabelEmail" runat="server" Text="Enter Email:"></asp:Label></td>
                        <td><asp:TextBox ID="TextBoxEmail" CssClass="TextBoxLogin" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="LabelPassword" runat="server" Text="Enter Password:"></asp:Label></td>
                        <td><asp:TextBox ID="TextBoxPassword" CssClass="TextBoxLogin" runat="server" TextMode="Password"></asp:TextBox></td>
                    </tr>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="2"><asp:Button ID="LoginSubmit" runat="server" Text="Login" OnClick="LoginSubmit_Click" CssClass="themedButton primary-bg hoverable" /></td>
                    </tr>
                    <tr>
                        <td colspan="2"><asp:Label ID="LabelError" runat="server" Text="" ForeColor="Red"></asp:Label></td>
                    </tr>
                </tfoot>
            </table>
        </div>
    </form>
</body>
</html>
