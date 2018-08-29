using System;
using System.Collections.Generic;
using System.Data.OleDb;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin : Page
{
    protected static string providerStr = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ProviderName;
    protected static string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["useremail"] == null) Response.Redirect("Login.aspx");
        if (Session["admin"].ToString() == "False") Response.Redirect("Landing.aspx");
    }

    protected void RefreshPage(object sender, EventArgs e)
    {
        Response.Redirect(Request.RawUrl);
    }

    protected void ButtonLanding_Click(object sender, EventArgs e)
    {
        Response.Redirect("Landing.aspx");
    }

    protected void ButtonLogout_Click(object sender, EventArgs e)
    {
        Session.Abandon();

        Response.Redirect("Login.aspx");
    }

    protected void ButtonAddUser_Click(object sender, EventArgs e)
    {
        // Server-side validation
        string firstName = TextBoxFname.Text;
        string lastName = TextBoxLname.Text;
        string password = TextBoxPassword.Text;
        string confirmPassword = TextBoxConfirmPassword.Text;
        string email = TextBoxEmail.Text;
        bool isAdmin = CheckBoxAdmin.Checked;
        string errorMsg = "";
        if (firstName == null || firstName.Length == 0) errorMsg = "Please enter a first name.";
        if (lastName == null || lastName.Length == 0) errorMsg = "Please enter a last name.";
        if (password == null || password.Length == 0) errorMsg = "Please enter a password.";
        if (email == null || email.Length == 0) errorMsg = "Pleaser enter an email address.";
        if (password != confirmPassword) errorMsg = "Passwords do not match.";
        if (password.Length < 8 || password.Length > 12) errorMsg = "Password must be between 8-12 characters.";

        if (errorMsg != "")
        {
            LabelSubmitErrorUser.Text = errorMsg;
            return;
        }

        // Gets a unique, unused user ID
        int userID = 0;
        List<int> existingUserIDs = GetExistingIDs(SelectIDMode.Users);
        while (existingUserIDs.Contains(userID))
        {
            if (userID >= int.MaxValue) throw new Exception("Max number of users reached");
            userID++;
        }

        // Applying arguments to SQL command
        SqlDS_Users.InsertParameters["UserID"].DefaultValue = userID.ToString();
        SqlDS_Users.InsertParameters["UserFirstName"].DefaultValue = firstName;
        SqlDS_Users.InsertParameters["UserLastName"].DefaultValue = lastName;
        SqlDS_Users.InsertParameters["UserPassword"].DefaultValue = password;
        SqlDS_Users.InsertParameters["UserEmail"].DefaultValue = email;
        SqlDS_Users.InsertParameters["Admin"].DefaultValue = isAdmin.ToString();

        SqlDS_Users.Insert();

        // Resetting parameters
        SqlDS_Users.InsertParameters["UserID"].DefaultValue = "";
        SqlDS_Users.InsertParameters["UserFirstName"].DefaultValue = "";
        SqlDS_Users.InsertParameters["UserLastName"].DefaultValue = "";
        SqlDS_Users.InsertParameters["UserPassword"].DefaultValue = "";
        SqlDS_Users.InsertParameters["UserEmail"].DefaultValue = "";
        SqlDS_Users.InsertParameters["Admin"].DefaultValue = "";

        // Closes the dialog box
        ScriptManager.RegisterStartupScript(this, GetType(), "closeDialog", "$('.dialog').dialog('close')", true);
    }

    protected void ButtonChangePassword_Click(object sender, EventArgs e)
    {
        int userID;
        string password = TextBoxChgPassword.Text;
        string confirmPassword = TextBoxChgConfirmPassword.Text;
        string errorMsg = "";
        if (!int.TryParse(DropDownChgPassword.SelectedItem.Value, out userID)) errorMsg = "Invalid User";
        if (password == null || password.Length == 0) errorMsg = "Please enter a password.";
        if (password != confirmPassword) errorMsg = "Passwords do not match.";
        if (password.Length < 8 || password.Length > 12) errorMsg = "Password must be between 8-12 characters.";

        if (errorMsg != "")
        {
            LabelSubmitErrorUser.Text = errorMsg;
            return;
        }

        // Creates a database connection through OleDb
        string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        OleDbConnection conn = new OleDbConnection(connStr);

        // Constructs the SQL command
        string queryStr = string.Format("UPDATE USERS SET UserPassword=? WHERE UserID=?");
        OleDbCommand command = new OleDbCommand(queryStr, conn);

        // Inserts values into parameters
        command.Parameters.AddWithValue("@UserPassword", password);
        command.Parameters.AddWithValue("@UserID", userID);

        // Opens the connection, executes the query, then closes it. ExecuteNonQuery() returns an int representing the number of rows affected.
        try
        {
            command.Connection.Open();
            command.ExecuteNonQuery();
        }
        finally
        {
            command.Connection.Close();
        }

        // Closes the dialog box
        ScriptManager.RegisterStartupScript(this, GetType(), "closeDialog", "$('.dialog').dialog('close')", true);

        // Refreshes the page
        //RefreshPage(sender, e);
    }

    protected void ButtonAddTool_Click(object sender, EventArgs e)
    {
        AddBookmark(TextBoxToolName.Text, TextBoxToolURL.Text, true);
    }

    protected void ButtonAddDoc_Click(object sender, EventArgs e)
    {
        AddBookmark(TextBoxDocName.Text, TextBoxDocURL.Text, false);
    }

    protected List<int> GetExistingIDs(SelectIDMode mode)
    {
        List<int> list = new List<int>();

        // Creates a database connection through OleDb
        OleDbConnection conn = new OleDbConnection(connStr);

        // Constructs the SQL command
        string queryStr;
        string fieldName;
        switch (mode)
        {
            case SelectIDMode.Users:
                queryStr = "SELECT UserID FROM USERS";
                fieldName = "UserID";
                break;
            case SelectIDMode.Tools:
                queryStr = "SELECT ToolID FROM TOOLS";
                fieldName = "ToolID";
                break;
            case SelectIDMode.Documents:
                queryStr = "SELECT DocumentID FROM DOCUMENTS";
                fieldName = "DocumentID";
                break;
            default:
                throw new ArgumentException("Invalid enum argument", "mode");
        }
        OleDbCommand command = new OleDbCommand(queryStr, conn);

        try
        {
            command.Connection.Open();
            OleDbDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                int id = -1;
                if (!int.TryParse(reader[fieldName].ToString(), out id)) continue;
                list.Add(id);
            }
        }
        finally
        {
            command.Connection.Close();
        }

        return list;
    }

    protected void AddBookmark(string displayName, string url, bool flag)
    {
        // Just in case this method is called without a Session...
        if (Session["useremail"] == null) Response.Redirect("Login.aspx");

        //Server-side validation
        string errorMsg = "";
        if (displayName == null || displayName.Length == 0) errorMsg = "Please enter a display name.";
        if (url == null || url.Length == 0) errorMsg = "Please enter a URL.";
        if (errorMsg != "")
        {
            Label label = flag ? LabelSubmitErrorTool : LabelSubmitErrorDoc;
            label.Text = errorMsg;
            return;
        }

        // Gets a unique, unused ID
        int id = 0;
        List<int> existingIDs = GetExistingIDs(flag ? SelectIDMode.Tools : SelectIDMode.Documents);
        while (existingIDs.Contains(id))
        {
            if (id >= int.MaxValue) throw new Exception(string.Format("Max number of {0} reached", flag ? "tools" : "documents"));
            id++;
        }

        SqlDataSource ds = flag ? SqlDS_Tools : SqlDS_Documents;

        // Applying arguments to SQL command
        ds.InsertParameters[flag ? "ToolID" : "DocumentID"].DefaultValue = id.ToString();
        ds.InsertParameters["Name"].DefaultValue = displayName;
        ds.InsertParameters["URL"].DefaultValue = url;

        ds.Insert();

        // Resetting parameters
        ds.InsertParameters[flag ? "ToolID" : "DocumentID"].DefaultValue = "";
        ds.InsertParameters["Name"].DefaultValue = "";
        ds.InsertParameters["URL"].DefaultValue = "";

        // Closes the dialog box
        ScriptManager.RegisterStartupScript(this, GetType(), "closeDialog", "$('.dialog').dialog('close')", true);
    }

    protected enum SelectIDMode
    {
        Users, Tools, Documents
    }
}