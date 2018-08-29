using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void LoginSubmit_Click(object sender, EventArgs e)
    {
        SqlDataSource objDS = new SqlDataSource();

        objDS.ProviderName = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ProviderName;
        objDS.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        //define sql statement - query with parameters
        objDS.SelectCommand = "select UserId, UserFirstName, UserLastName, UserEmail, Admin from users where useremail=? and userpassword=?";

        //tell where to get the values of the parameters
        objDS.SelectParameters.Add("useremail", TextBoxEmail.Text);
        objDS.SelectParameters.Add("userpassword", TextBoxPassword.Text);

        //sets mode of how we are going to use data... simpler option
        objDS.DataSourceMode = SqlDataSourceMode.DataReader;

        //executes the query - stores the results - in sort of an array = read sequentially
        System.Data.IDataReader myData = (System.Data.IDataReader)objDS.Select(DataSourceSelectArguments.Empty);

        //read the next row - since his is the first read
        //it reads the first row in the result set...
        try
        {
            if (myData.Read())
            {
                // the first read found a row, and returned true
                //therefore
                //successful logon!
                Session["userid"] = myData[0];
                Session["userfirstname"] = myData[1];
                Session["userlastname"] = myData[2];
                Session["useremail"] = myData[3];
                Session["admin"] = myData[4];
                //redirect to default.aspx
                Response.Redirect("Landing.aspx");
            }
            else
            {
                // the first read did not find a row, and returned false
                //therefore
                //unsuccessful logon!
                //set message
                LabelError.Text = "*Unsuccessful";
                //LabelError.ForeColor = System.Drawing.Color.Red;
            }
        }

        catch
        {
            LabelError.Text = "*Unsuccessful";
            //LabelError.ForeColor = System.Drawing.Color.Red;
        }
    }
}