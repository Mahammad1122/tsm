using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TaskManagement.config;
using System.Configuration;
using System.Data.SqlClient;
namespace TaskManagement
{
    public partial class ForgetPassword : System.Web.UI.Page
    {
        private static string strCon = ConfigurationManager.ConnectionStrings["taskManagementDB"].ConnectionString;
        SqlConnection con = new SqlConnection(strCon);
        EmailService emailService = new EmailService();
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnSendOtp_Click(object sender, EventArgs e)
        {
            bool IsExists = checkExistEmail(txtUserEmail.Text);
            if (IsExists)
            {
                Session["otp"] = OTPService.GenerateOTP();
                Session["otpGeneratedTime"] = DateTime.Now;
                string msg = "Use OTP <b>"+Session["otp"]+"</b> to reset your password.";
                string isSend = emailService.SendEmail(txtUserEmail.Text, "Reset Password OTP", msg);
                if (isSend == "1")
                {
                    mvForm.ActiveViewIndex = 1;
                }
                else {
                    Response.Write("<script>alert('"+isSend+"')</script>");
                }
            }
            else {
                lblEmailAlert.Visible = true;
            }
        }

        protected void btnVerifyOtp_Click(object sender, EventArgs e)
        {
            DateTime generatedOtpTime = Convert.ToDateTime(Session["otpGeneratedTime"]);
            bool isValid = OTPService.VerifyOTP(Session["otp"].ToString(), txtVerifyOtp.Text, generatedOtpTime);
            if (isValid)
            {
                mvForm.ActiveViewIndex = 2;
            }
            else {
                lblVerifyAlert.Visible = true;
            }
        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            if (txtNewPassword.Text.Length < 8)
            {
                lblResetAlert.Text = "Password must be 8 character long";
                lblResetAlert.Visible = true;
            }
            else if (txtNewPassword.Text != txtConfirmPassword.Text)
            {
                lblResetAlert.Text = "Password Does not match";
                lblResetAlert.Visible = true;
            }
            else
            {
                string password = PasswordEncryption.HashPassword(txtNewPassword.Text);
                SqlCommand cmd = new SqlCommand("UPDATE users SET password = @password WHERE id = @userId",con);
                cmd.Parameters.AddWithValue("@password", password);
                cmd.Parameters.AddWithValue("@userId", Session["userId"]);
                con.Open();
                if (cmd.ExecuteNonQuery() > 0)
                {
                    Session.Clear();
                    Response.Redirect("login.aspx");
                }
                else {
                    lblResetAlert.Text = "Password not changed";
                    lblResetAlert.Visible = true;
                }
            }
        }
        private bool checkExistEmail(string email)
        {
            SqlCommand cmd = new SqlCommand("SELECT * FROM users where email = @email",con);
            cmd.Parameters.AddWithValue("@email", email);
            con.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                if (email == sdr["email"].ToString())
                {
                    Session["userId"] = sdr["id"];
                    return true;
                }
            }
            return false;
        }
    }
}