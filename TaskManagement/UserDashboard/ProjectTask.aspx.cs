using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using TaskManagement.config;
namespace TaskManagement.UserDashboard
{
    public partial class ProjectTask : System.Web.UI.Page
    {
        private static string strCon = ConfigurationManager.ConnectionStrings["taskManagementDB"].ConnectionString;
        SqlConnection con = new SqlConnection(strCon);
        private static int projectId = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userId"] != null)
            {
                if (Request.QueryString["project_id"] != null)
                {
                    projectId = Convert.ToInt32(Request.QueryString["project_id"]);
                    fetchProjectData(projectId);
                }
                if (!IsPostBack)
                {
                    bindProjectTaskData("bindData", null);
                }
            }
            else {
                Response.Redirect("../login.aspx");
            }
        }
        private void fetchProjectData(int id) {
            SqlCommand cmd = new SqlCommand("SELECT * From projects WHERE id = @id", con);
            cmd.Parameters.AddWithValue("@id", id);
            con.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            if (sdr.Read()) {
                lblProjectName.Text = sdr["project_name"].ToString();
                lblProjectDetail.Text = "Project details : "+sdr["description"].ToString();
            }
            con.Close();
        }
        private void bindProjectTaskData(string operation, string value) 
        {
            SqlCommand cmd = new SqlCommand();
            if (operation == "bindData")
            {
                cmd = new SqlCommand("SELECT * FROM task_master WHERE project_id = @project_id ORDER BY id DESC", con);
                cmd.Parameters.AddWithValue("@project_id", projectId);
            }
            else if (operation == "taskSearch")
            {
                cmd = new SqlCommand("SELECT * FROM task_master WHERE (project_id = @project_id) AND (task_name LIKE '%'+@search+'%' OR priority LIKE '%'+@search+'%') ORDER BY id DESC", con);
                cmd.Parameters.AddWithValue("@search", value);
                cmd.Parameters.AddWithValue("@project_id", projectId);

            }
            else if (operation == "statusFilter")
            {
                cmd = new SqlCommand("SELECT * FROM task_master WHERE (project_id = @project_id) AND (status =@status OR priority=@status) ORDER BY id DESC", con);
                cmd.Parameters.AddWithValue("@status", value);
                cmd.Parameters.AddWithValue("@project_id", projectId);
            }
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            dlTask.DataSource = ds;
            dlTask.DataBind();
        }

        protected void btnCreateTask_Click(object sender, EventArgs e)
        {
            if (mvTask.ActiveViewIndex == 0)
            {
                mvTask.ActiveViewIndex = 1;
                bindEmployeeData();
            }
            else {
                mvTask.ActiveViewIndex = 0;
            }
        }

        protected void mvTask_ActiveViewChanged(object sender, EventArgs e)
        {
            if (mvTask.ActiveViewIndex == 0)
            {
                lblTaskTitle.Text = "All Tasks";
                btnCreateTask.Text = "Create Task";
                btnCreateTask.Visible = true;
            }
            else if (mvTask.ActiveViewIndex == 1)
            {
                lblTaskTitle.Text = "Create Task";
                btnCreateTask.Text = "All Tasks";
                btnCreateTask.Visible = true;
            }
            else if (mvTask.ActiveViewIndex == 2)
            {
                lblTaskTitle.Text = "Update Task";
                btnCreateTask.Visible = false;
            }
        }

        protected void btnTaskCreate_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("INSERT INTO task_master (task_name,description,due_date,priority,status,created_by_user,assigned_user_id,project_id,created_at,task_type) VALUES(@task_name,@description,@due_date,@priority,@status,@created_by_user,@assigned_user_id,@project_id,@created_at,@task_type)", con);
            cmd.Parameters.AddWithValue("@task_name", txtTaskName.Text);
            cmd.Parameters.AddWithValue("@description", txtTaskDetails.Text);
            cmd.Parameters.AddWithValue("@due_date", txtTaskDeadline.Text);
            cmd.Parameters.AddWithValue("@priority", ddlTaskPriority.SelectedValue);
            cmd.Parameters.AddWithValue("@status", "In Progress");
            cmd.Parameters.AddWithValue("@created_by_user", Convert.ToInt32(Session["userId"]));
            cmd.Parameters.AddWithValue("@assigned_user_id",ddlEmployee.SelectedItem.Value);
            cmd.Parameters.AddWithValue("@project_id", projectId);
            cmd.Parameters.AddWithValue("@created_at", DateTime.Now.ToShortDateString());
            cmd.Parameters.AddWithValue("@task_type", "project");
            con.Open();
            if (cmd.ExecuteNonQuery() > 0)
            {
                Notification notification = new Notification();
                int IsSend = notification.sendNotification(Convert.ToInt32(ddlEmployee.SelectedValue), "task", txtTaskName.Text);
                EmailService email = new EmailService();
                string msg = "This task is assigned by "+Session["userName"]+"<br/><br/>"+txtTaskDetails.Text;
                string subject = lblProjectName.Text + " : " + txtTaskName.Text;
                string assignedUserEmail = ddlEmployee.SelectedItem.Text;
                if (email.SendEmail(assignedUserEmail, subject, msg) == "1")
                {
                    bindProjectTaskData("bindData", null);
                    mvTask.ActiveViewIndex = 0;
                }
                else {
                    Response.Write("<script>alert('mail not sent to user')</script>");
                }
            }
            con.Close();
        }
        private void bindEmployeeData() 
        {
            ddlEmployee.Items.Clear();
            SqlDataAdapter sda = new SqlDataAdapter("SELECT * FROM users WHERE role = 1",con);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            ddlEmployee.Items.Add("- - - Select Employee email - - -");
            ddlEmployee.DataSource = ds;
            ddlEmployee.DataTextField = "email";
            ddlEmployee.DataValueField = "id";
            ddlEmployee.DataBind();
        }

        protected void dlTask_DeleteCommand(object source, DataListCommandEventArgs e)
        {
            int id = Convert.ToInt32((e.Item.FindControl("chkTask") as CheckBox).Text);
            SqlCommand cmd = new SqlCommand("DELETE FROM task_master WHERE id=@id", con);
            cmd.Parameters.AddWithValue("@id", id);
            con.Open();
            if (cmd.ExecuteNonQuery() > 0)
            {
                bindProjectTaskData("bindData", null);
            }
            con.Close();
        }

        protected void dlTask_EditCommand(object source, DataListCommandEventArgs e)
        {
            DataListItem item = e.Item;
            hfTaskId.Value = (item.FindControl("chkTask") as CheckBox).Text;
            txtEditTaskName.Text = (item.FindControl("lblTaskName") as Label).Text;
            txtEditTaskDetails.Text = (item.FindControl("lblTaskDescription") as Label).Text;
            DateTime taskDueDate = Convert.ToDateTime((item.FindControl("lblTaskDueDate") as Label).Text);
            txtEditTaskDeadline.Text = taskDueDate.ToString("yyyy-MM-dd");
            ddlEditTaskStatus.SelectedValue = (item.FindControl("lblTaskStatus") as Label).Text;
            ddlEditTaskPriority.SelectedValue = (item.FindControl("lblTaskPriority") as Label).Text;
            mvTask.ActiveViewIndex = 2;
        }
        static string btnText = null;
        static int btnCount = 0;
        protected void taskFilterStatus(object sender, EventArgs e)
        {
            Button btnFilter = sender as Button;
            if (btnFilter != null)
            {
                if (btnText == null)
                {
                    btnText = btnFilter.Text;
                    bindProjectTaskData("statusFilter", btnFilter.Text);
                    lblTaskTitle.Text = btnFilter.Text + " Tasks";
                    btnCount = 0;
                }
                else if (btnText == btnFilter.Text && btnCount < 1)
                {
                    lblTaskTitle.Text = "All Tasks";
                    bindProjectTaskData("bindData", null);
                    btnCount++;
                }
                else
                {
                    btnText = btnFilter.Text;
                    lblTaskTitle.Text = btnFilter.Text + " Tasks";
                    bindProjectTaskData("statusFilter", btnFilter.Text);
                    btnCount = 0;
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("UPDATE task_master SET task_name = @task_name, description = @description, due_date = @due_date, priority = @priority, status = @status, modified_at = @modified_at WHERE id = @id", con);
            cmd.Parameters.AddWithValue("@id", hfTaskId.Value);
            cmd.Parameters.AddWithValue("@task_name", txtEditTaskName.Text);
            cmd.Parameters.AddWithValue("@description", txtEditTaskDetails.Text);
            cmd.Parameters.AddWithValue("@due_date", txtEditTaskDeadline.Text);
            cmd.Parameters.AddWithValue("@priority", ddlEditTaskPriority.SelectedValue);
            cmd.Parameters.AddWithValue("@status", ddlEditTaskStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@modified_at", DateTime.Now.ToShortDateString());
            con.Open();
            if (cmd.ExecuteNonQuery() > 0)
            {
                mvTask.ActiveViewIndex = 0;
                bindProjectTaskData("bindData", null);
            }
            con.Close();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (txtTaskSearch.Text.Trim() != "")
            {
                bindProjectTaskData("taskSearch", txtTaskSearch.Text);
            }
            else
            {
                bindProjectTaskData("bindData", null);
            }
        }
    }   
}