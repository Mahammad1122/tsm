using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace TaskManagement.UserDashboard
{
    public partial class message : System.Web.UI.Page
    {
        private static string strCon = ConfigurationManager.ConnectionStrings["taskManagementDB"].ConnectionString;
        SqlConnection con = new SqlConnection(strCon);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userId"] == null)
            {
                Response.Redirect("../login.aspx");
            }
            bindUserData();   
        }
        private void bindUserData() 
        {
            SqlCommand cmd = new SqlCommand("SELECT DISTINCT u.* FROM users u JOIN task_master t ON (u.id = t.created_by_user AND u.role = 0 AND t.assigned_user_id = @userId) OR (u.id = t.assigned_user_id AND u.role = 1 AND t.created_by_user = @userId)", con);
            cmd.Parameters.AddWithValue("@userId",Session["userId"]);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            rpUser.DataSource = ds;
            rpUser.DataBind();
        }
        private static int ReceiverId = 0;
        protected void rpUser_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Click") {
                ReceiverId = Convert.ToInt32(e.CommandArgument);
                bindMessage();
            }
        }
        private void bindMessage() 
        {
            SqlCommand cmd = new SqlCommand("SELECT m.id, m.sender_id, u.name AS sender_name, m.receiver_id, m.message_text, m.created_at FROM messages m JOIN users u ON m.sender_id = u.id WHERE (m.sender_id = @userId AND m.receiver_id = @chatUserId) OR (m.sender_id = @chatUserId AND m.receiver_id = @userId) ORDER BY m.created_at ASC",con);
            cmd.Parameters.AddWithValue("@userId", Session["userId"]);
            cmd.Parameters.AddWithValue("@chatUserId", ReceiverId);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            rpChat.DataSource = ds;
            rpChat.DataBind();
        }
        protected void Timer1_Tick(object sender, EventArgs e)
        {
            bindMessage();
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            if (txtMsg.Text.Trim() != "") {
                SqlCommand cmd = new SqlCommand("INSERT INTO messages VALUES (@sender_id,@receiver_id,@message_text,@created_at)",con);
                cmd.Parameters.AddWithValue("@sender_id", Session["userId"]);
                cmd.Parameters.AddWithValue("@receiver_id", ReceiverId);
                cmd.Parameters.AddWithValue("@message_text", txtMsg.Text);
                cmd.Parameters.AddWithValue("@created_at",DateTime.Now);
                con.Open();
                if (cmd.ExecuteNonQuery() > 0)
                {
                    txtMsg.Text = "";
                    bindMessage();
                }
                else {
                    Response.Write("<script>alert('There was an error to sendind message')</script>");
                }
                con.Close();
            }
        }
    }
}