using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using TaskManagement.config;
namespace TaskManagement.UserDashboard
{
    public partial class overview : System.Web.UI.Page
    {
        private static string strCon = ConfigurationManager.ConnectionStrings["taskManagementDB"].ConnectionString;
        SqlConnection con = new SqlConnection(strCon);
        Notification notification = new Notification();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userId"] == null)
            {
                Response.Redirect("../login.aspx");
            }
            else {
                lblUserName.Text = Session["userName"].ToString();
                UserProfileImage.ImageUrl = Session["userImage"].ToString();
            }
            if (!IsPostBack) {
                bindTodayTaskData();
                bindNotification();
                getOverviewData();
            }
            if (Convert.ToInt32(Session["userRole"]) == 0)
            {
                checkProjectDueDate();
            }
            checkTaskDueData();
        }
        private void checkTaskDueData() {
            SqlCommand cmd = new SqlCommand("SELECT * FROM task_master where created_by_user = @userId OR assigned_user_id = @userId",con);
            cmd.Parameters.AddWithValue("@userId",Session["userId"]);
            con.Open();
            DateTime tomorrowDate = DateTime.Now.AddDays(1);
            SqlDataReader sdr = cmd.ExecuteReader();
            while (sdr.Read()) {
                DateTime dueDate = Convert.ToDateTime(sdr["due_date"]);
                if (dueDate.ToShortDateString() == tomorrowDate.ToShortDateString()) {
                    string msg = "Task " + sdr["task_name"] + " is Due on " + dueDate.ToShortDateString();
                    int IsSend = notification.sendNotification(Convert.ToInt32(Session["userId"]), "reminder", msg);
                }
            }
            bindNotification();
            con.Close();
        }
        private void checkProjectDueDate()
        {
            SqlCommand cmd = new SqlCommand("SELECT * FROM projects where created_by_user = @userId",con);
            cmd.Parameters.AddWithValue("@userId", Session["userId"]);
            con.Open();
            DateTime tomorrowDate = DateTime.Now.AddDays(1);
            SqlDataReader sdr = cmd.ExecuteReader();
            while (sdr.Read())
            {
                DateTime DueDate = Convert.ToDateTime(sdr["end_date"]);
                if(DueDate.ToShortDateString() == tomorrowDate.ToShortDateString()){
                    string msg = "Project :" + sdr["project_name"] + " is Due on " + DueDate.ToShortDateString();
                    int IsSend = notification.sendNotification(Convert.ToInt32(Session["userId"]), "projectReminder", msg);
                }
            }
            con.Close();
        }
        private void bindTodayTaskData() {
            SqlCommand cmd = new SqlCommand("SELECT task_name,status FROM task_master WHERE (created_by_user = @userId AND task_type='personal') AND (due_date = CAST(GETDATE() AS DATE) OR status = 'pending' OR (due_date < CAST(GETDATE() AS DATE) AND status != 'completed')) ORDER BY priority DESC, due_date ASC, status DESC",con);
            cmd.Parameters.AddWithValue("@userId",Session["userId"]);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            repeaterTask.DataSource = ds;
            repeaterTask.DataBind();
        }
        private void bindNotification() {
            DataSet ds = notification.ReceiveNotification(Convert.ToInt32(Session["userId"]));
            rpNotification.DataSource = ds;
            rpNotification.DataBind();
        }

        protected void rpNotification_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Click") {
                int isRead = notification.readNotification(Convert.ToInt32(e.CommandArgument));
                if (isRead == 1) {
                    bindNotification();
                }
            }
        }
        private void getOverviewData() 
        {
            getTotalTask();
            getCompletedTask();
            getOverDueTask();
        }
        private void getTotalTask() 
        {
            SqlCommand cmd = new SqlCommand("SELECT COUNT(t.id) AS total_task FROM task_master AS t INNER JOIN users AS u ON t.created_by_user = u.id WHERE (u.id = @userId) AND (u.role = 0) AND (t.task_type = 'personal') OR (u.id = @userId) AND (u.role = 1) AND (t.task_type = 'personal') OR (t.assigned_user_id = @userId)", con);
            cmd.Parameters.AddWithValue("@userId", Session["userId"]);
            con.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                lblTotalTask.Text = sdr["total_task"].ToString();
            }
            else {
                lblTotalTask.Text = "0";
            }
            con.Close();
        }
        private void getOverDueTask()
        {
            SqlCommand cmd = new SqlCommand("SELECT COUNT(t.id) AS overdue_task FROM task_master AS t INNER JOIN users AS u ON t.created_by_user = u.id WHERE ((u.id = @userId) AND (u.role = 0) AND (t.task_type = 'personal') OR (u.id = @userId) AND (u.role = 1) AND (t.task_type = 'personal') OR (t.assigned_user_id = @userId)) AND (t.due_date < GETDATE() AND t.status !='Completed')", con);
            cmd.Parameters.AddWithValue("@userId", Session["userId"]);
            con.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                lblTaskOverDue.Text = sdr["overdue_task"].ToString();
            }
            else
            {
                lblTaskOverDue.Text = "0";
            }
            con.Close();
        }
        private void getCompletedTask()
        {
            SqlCommand cmd = new SqlCommand("SELECT COUNT(t.id) AS completed_task FROM task_master AS t INNER JOIN users AS u ON t.created_by_user = u.id WHERE ((u.id = @userId) AND (u.role = 0) AND (t.task_type = 'personal') OR (u.id = @userId) AND (u.role = 1) AND (t.task_type = 'personal') OR (t.assigned_user_id = @userId)) AND t.status = 'Completed'", con);
            cmd.Parameters.AddWithValue("@userId", Session["userId"]);
            con.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            if (sdr.Read())
            {
                lblTaskCompleted.Text = sdr["completed_task"].ToString();
            }
            else
            {
                lblTaskCompleted.Text = "0";
            }
            con.Close();
        }
    }
}