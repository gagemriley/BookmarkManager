using System;
using System.Collections.Generic;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Landing : Page
{
    protected static string providerStr = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ProviderName;
    protected static string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["useremail"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        if (Session["admin"].ToString() == "True")
        {
            ButtonAdmin.Visible = true;
        }

        ScriptManager.RegisterStartupScript(UP_NewFav, GetType(), "refreshFavicons", "javascript:landingPageApp_ns.common_ns.refreshFavicons()", true);
        ScriptManager.RegisterStartupScript(UP_EditFav, GetType(), "refreshFavicons", "javascript:landingPageApp_ns.common_ns.refreshFavicons()", true);
        ScriptManager.RegisterStartupScript(UP_NewPolicy, GetType(), "refreshFavicons", "javascript:landingPageApp_ns.common_ns.refreshFavicons()", true);
        ScriptManager.RegisterStartupScript(UP_EditPolicy, GetType(), "refreshFavicons", "javascript:landingPageApp_ns.common_ns.refreshFavicons()", true);
    }

    protected void RefreshPage(object sender, EventArgs e)
    {
        Response.Redirect(Request.RawUrl);
    }

    protected void ButtonAdmin_Click(object sender, EventArgs e)
    {
        Response.Redirect("Admin.aspx");
    }

    protected void ButtonLogout_Click(object sender, EventArgs e)
    {
        Session.Abandon();

        Response.Redirect("Login.aspx");
    }

    protected void ButtonAddFavorite_Click(object sender, EventArgs e)
    {
        AddBookmark(TextBoxFavName.Text, TextBoxFavURL.Text, true);
    }

    protected void ButtonAddPolicy_Click(object sender, EventArgs e)
    {
        AddBookmark(TextBoxPolicyName.Text, TextBoxPolicyURL.Text, false);
    }

    protected void AddBookmark(string displayName, string url, bool flag)
    {
        // Just in case this method is called without a Session...
        if (Session["useremail"] == null) { Response.Redirect("Login.aspx"); return; }

        int userID;
        if(!int.TryParse(Session["userid"].ToString(), out userID)){
            // This shouldn't happen, but just in case...
            Response.Redirect("Login.aspx");
            return;
        }

        // Server-side validation
        if (displayName == null || displayName.Length == 0) { ReturnError("Please enter a display name.", flag); return; }
        if (url == null || url.Length == 0) { ReturnError("Please enter a URL.", flag); return; }
        if (!Uri.IsWellFormedUriString(url, UriKind.Absolute)) { ReturnError("Invalid URL", flag); return; }

        // Gets a unique, unused bookmarkID for the user
        int bookmarkID = 0;
        List<int> existingIDs = GetExistingBookmarkIDs(userID);
        while (existingIDs.Contains(bookmarkID))
        {
            if (bookmarkID >= int.MaxValue) throw new Exception("Max number of bookmarks reached");
            bookmarkID++;
        }

        // Applying arguments to SQL command
        // For this particular case, using SqlDS_Favorites and SqlDS_Policies would have the same effect, as they call the same fields on the same table, just with different filters.
        SqlDS_Favorites.InsertParameters["BookmarkID"].DefaultValue = bookmarkID.ToString();
        SqlDS_Favorites.InsertParameters["UserID_FK"].DefaultValue = userID.ToString();
        SqlDS_Favorites.InsertParameters["Name"].DefaultValue = displayName;
        SqlDS_Favorites.InsertParameters["URL"].DefaultValue = url;
        SqlDS_Favorites.InsertParameters["Type"].DefaultValue = flag.ToString();

        SqlDS_Favorites.Insert();

        // Resetting parameters
        SqlDS_Favorites.InsertParameters["BookmarkID"].DefaultValue = "";
        SqlDS_Favorites.InsertParameters["UserID_FK"].DefaultValue = "";
        SqlDS_Favorites.InsertParameters["Name"].DefaultValue = "";
        SqlDS_Favorites.InsertParameters["URL"].DefaultValue = "";
        SqlDS_Favorites.InsertParameters["Type"].DefaultValue = "";

        // Closes the dialog box
        ScriptManager.RegisterStartupScript(this, GetType(), "closeDialog", "$('.dialog').dialog('close')", true);
    }

    protected void ReturnError(string errorMsg, bool flag)
    {
        Label label = flag ? LabelSubmitErrorFav : LabelSubmitErrorPolicy;
        label.Text = errorMsg;
    }

    protected List<int> GetExistingBookmarkIDs(int userID)
    {
        List<int> list = new List<int>();

        // Creates a database connection through OleDb
        OleDbConnection conn = new OleDbConnection(connStr);

        // Constructs the SQL command
        string queryStr = "SELECT BookmarkID FROM USER_BOOKMARKS WHERE [UserID_FK] = ?";
        OleDbCommand command = new OleDbCommand(queryStr, conn);

        command.Parameters.AddWithValue("@UserID_FK", userID);

        try
        {
            command.Connection.Open();
            OleDbDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                int id = -1;
                if (!int.TryParse(reader["BookmarkID"].ToString(), out id)) continue;
                list.Add(id);
            }
        }
        finally
        {
            command.Connection.Close();
        }

        return list;
    }

}