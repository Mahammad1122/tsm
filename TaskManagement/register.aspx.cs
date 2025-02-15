using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using TaskManagement.config;
namespace TaskManagement
{
    public partial class register : System.Web.UI.Page
    {
        static string conStr = ConfigurationManager.ConnectionStrings["taskManagementDB"].ConnectionString;
        private SqlConnection con = new SqlConnection(conStr);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] != null) {
                Response.Redirect("UserDashBoard/overview.aspx");
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (checkExistUser(txtUserEmail.Text) == 0)
            {
                return;
            }
            string hashPassword = PasswordEncryption.HashPassword(txtUserPassword.Text);
            string imgUrl = userProfileUpload();
            SqlCommand cmd = new SqlCommand("INSERT INTO users VALUES(@name,@email,@password,@role,@created_at,@img_url)",con);
            cmd.Parameters.AddWithValue("@name",txtUserName.Text);
            cmd.Parameters.AddWithValue("@email", txtUserEmail.Text);
            cmd.Parameters.AddWithValue("@password",hashPassword);
            cmd.Parameters.AddWithValue("@role",ddlUserRole.SelectedValue);
            cmd.Parameters.AddWithValue("@created_at", DateTime.Now.ToShortDateString());
            cmd.Parameters.AddWithValue("@img_url", imgUrl);
            con.Close();
            con.Open();
            try
            {
                
                int i = cmd.ExecuteNonQuery();
                if (i > 0)
                {
                    Response.Redirect("login.aspx");
                }
                else
                {
                    lblAlert.Text = "Not Registered";
                    lblAlert.Visible = true;
                }
            }
            catch (Exception err)
            {
                Response.Write("Error = " + err.Message);
            }
            finally {
                con.Close();
            }
        }
        private string userProfileUpload() {
            if (fuUserImage.HasFile) {
                fuUserImage.SaveAs(Server.MapPath("~/userProfileImage/"+fuUserImage.FileName));
            }
            return "~/userProfileImage/" + fuUserImage.FileName;
        }
        private int checkExistUser(string Email)
        {
            SqlCommand cmd = new SqlCommand("Select * from users where email = @email", con);
            cmd.Parameters.AddWithValue("@email", Email);
            con.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                lblAlert.Text = "User already exists";
                lblAlert.Visible = true;
                con.Close();
                return 0;
            }
            else {
                con.Close();
                return 1;
            }
        }
    }
}