using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using TaskManagement.config;
namespace TaskManagement
{
    public partial class login : System.Web.UI.Page
    {
        static string conStr = ConfigurationManager.ConnectionStrings["taskManagementDB"].ConnectionString;
        private SqlConnection con = new SqlConnection(conStr);
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["userLogin"] != null) {
                Response.Redirect("UserDashBoard/overview.aspx");
            }
            if (Request.Cookies["userInfo"] != null) {
                checkCookiesData(Request.Cookies["userInfo"]);
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("SELECT * FROM users WHERE email=@email",con);
            cmd.Parameters.AddWithValue("@email", txtUserEmail.Text);
            con.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            if (sdr.Read()) {
                if (PasswordEncryption.VerifyPassword(txtUserPassword.Text, sdr["password"].ToString())) {
                    Session["userRole"] = sdr["role"];
                    Session["userId"] = sdr["id"].ToString();
                    Session["userName"] = sdr["name"].ToString();
                    //set Cookie
                    if (chkRemember.Checked) {
                        HttpCookie userInfo = new HttpCookie("userInfo");
                        userInfo["email"] = txtUserEmail.Text;
                        userInfo["password"] = PasswordEncryption.HashPassword(txtUserPassword.Text);
                        userInfo["lastVisit"] = DateTime.Now.ToString();
                        userInfo.Expires = DateTime.Now.AddDays(7);
                        Response.Cookies.Add(userInfo);
                    }
                    Response.Redirect("UserDashBoard/overview.aspx");
                }
            }
            con.Close();
        }
        private void checkCookiesData(HttpCookie userInfo) {
            TimeSpan timeSinceLastVisit = DateTime.Now - Convert.ToDateTime(userInfo["lastVisit"]);

            if (timeSinceLastVisit.TotalDays >= 7)
            {
                userInfo.Expires = DateTime.Now.AddDays(-1); // Expire immediately
            }
            else
            {
                // Update the last visit time in the cookie
                userInfo.Values["LastVisit"] = DateTime.Now.ToString();
                SqlCommand cmd = new SqlCommand("SELECT * FROM users WHERE email=@email", con);
                cmd.Parameters.AddWithValue("@email", userInfo["email"]);
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    if (PasswordEncryption.VerifyPassword(userInfo["password"], sdr["password"].ToString()))
                    {
                        Session["userRole"] = sdr["role"];
                        Session["userId"] = sdr["id"].ToString();
                        Session["userName"] = sdr["name"].ToString();
                        Response.Redirect("UserDashBoard/overview.aspx");
                    }
                }
                con.Close();
            }
        }
    }
}