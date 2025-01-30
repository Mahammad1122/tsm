using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace TaskManagement.Dashboard
{
    public partial class task : System.Web.UI.Page
    {
        private static string strCon = ConfigurationManager.ConnectionStrings["taskManagementDB"].ConnectionString;
        SqlConnection con = new SqlConnection(strCon);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userId"] == null)
            {
                Response.Redirect("../login.aspx");
            }
            else {
                lblUserName.Text = Session["userName"].ToString();
            }
            if (!IsPostBack) {
                bindTaskData("bindData",null);
            }
        }

        protected void btnCreateTask_Click(object sender, EventArgs e)
        {
            mvTask.ActiveViewIndex = mvTask.ActiveViewIndex == 0 ? 1 : 0;
        }
        private void bindTaskData(string operation,string value) 
        {
            SqlCommand cmd = new SqlCommand();
            if (operation == "bindData") {
                cmd = new SqlCommand("SELECT t.* FROM task_master AS t INNER JOIN users AS u ON t.created_by_user = u.id WHERE (u.id = @userId) AND (u.role = 0) AND (t.task_type = 'personal') OR (u.id = @userId) AND (u.role = 1) AND (t.task_type = 'personal') OR (t.assigned_user_id = @userId) ORDER BY id DESC", con);
                cmd.Parameters.AddWithValue("@userId",Session["userId"]);
            }
            else if (operation == "taskSearch")
            {
                cmd = new SqlCommand("SELECT t.* FROM task_master AS t INNER JOIN users AS u ON t.created_by_user = u.id WHERE ((u.id = @userId) AND (u.role = 0) AND (t.task_type = 'personal') OR (u.id = @userId) AND (u.role = 1) AND (t.task_type = 'personal') OR (t.assigned_user_id = @userId)) AND (task_name LIKE '%'+@search+'%' OR priority LIKE '%'+@search+'%') ORDER BY id DESC", con);
                cmd.Parameters.AddWithValue("@search", value);
                cmd.Parameters.AddWithValue("@userId", Session["userId"]);

            }
            else if (operation == "statusFilter")
            {
                cmd = new SqlCommand("SELECT t.* FROM task_master AS t INNER JOIN users AS u ON t.created_by_user = u.id WHERE ((u.id = @userId) AND (u.role = 0) AND (t.task_type = 'personal') OR (u.id = @userId) AND (u.role = 1) AND (t.task_type = 'personal') OR (t.assigned_user_id = @userId)) AND status =@status ORDER BY id DESC", con);
                cmd.Parameters.AddWithValue("@status", value);
                cmd.Parameters.AddWithValue("@userId", Session["userId"]);      
            }
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            dlTask.DataSource = ds;
            dlTask.DataBind();
        }
        protected void btnTaskCreate_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("INSERT INTO task_master (task_name,description,due_date,priority,status,created_by_user,created_at,task_type) VALUES(@task_name,@description,@due_date,@priority,@status,@created_by_user,@created_at,@task_type)",con);
            cmd.Parameters.AddWithValue("@task_name",txtTaskName.Text);
            cmd.Parameters.AddWithValue("@description", txtTaskDetails.Text);
            cmd.Parameters.AddWithValue("@due_date", txtTaskDeadline.Text);
            cmd.Parameters.AddWithValue("@priority",ddlTaskPriority.SelectedValue);
            cmd.Parameters.AddWithValue("@status","In Progress");
            cmd.Parameters.AddWithValue("@created_by_user", Convert.ToInt32(Session["userId"]));
            cmd.Parameters.AddWithValue("@created_at",DateTime.Now.ToShortDateString());
            cmd.Parameters.AddWithValue("@task_type", "personal");
            con.Open();
            if (cmd.ExecuteNonQuery() > 0) {
                bindTaskData("bindData",null);
                mvTask.ActiveViewIndex = 0;
            }
            con.Close();
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

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("UPDATE task_master SET task_name = @task_name, description = @description, due_date = @due_date, priority = @priority, status = @status, modified_at = @modified_at WHERE id = @id",con);
            cmd.Parameters.AddWithValue("@id", hfTaskId.Value);
            cmd.Parameters.AddWithValue("@task_name", txtEditTaskName.Text);
            cmd.Parameters.AddWithValue("@description",txtEditTaskDetails.Text);
            cmd.Parameters.AddWithValue("@due_date", txtEditTaskDeadline.Text);
            cmd.Parameters.AddWithValue("@priority",ddlEditTaskPriority.SelectedValue);
            cmd.Parameters.AddWithValue("@status",ddlEditTaskStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@modified_at",DateTime.Now.ToShortDateString());
            con.Open();
            if (cmd.ExecuteNonQuery() > 0) {
                mvTask.ActiveViewIndex = 0;
                bindTaskData("bindData",null);
            }
            con.Close();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (txtTaskSearch.Text.Trim() != null)
            {
                bindTaskData("taskSearch", txtTaskSearch.Text);
            }
            else {
                bindTaskData("bindData", null);
            }
        }
        static string btnText = null;
        static int btnCount = 0;
        protected void taskFilterStatus(object sender, EventArgs e) 
        {
            Button btnFilter = sender as Button;
            if (btnFilter != null) {
                if (btnText == null) {
                    btnText = btnFilter.Text;
                    bindTaskData("statusFilter", btnFilter.Text);
                    lblTaskTitle.Text = btnFilter.Text + "Task";
                    btnCount = 0;
                }
                else if (btnText == btnFilter.Text && btnCount < 1)
                {
                    lblTaskTitle.Text = "All Task";
                    bindTaskData("bindData", null);
                    btnCount++;
                }
                else{
                    btnText = btnFilter.Text;
                    lblTaskTitle.Text = btnFilter.Text + "Task";
                    bindTaskData("statusFilter", btnFilter.Text);
                    btnCount = 0;
                }
            }
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

        protected void dlTask_DeleteCommand(object source, DataListCommandEventArgs e)
        {
            int id  = Convert.ToInt32((e.Item.FindControl("chkTask") as CheckBox).Text);
            SqlCommand cmd = new SqlCommand("DELETE FROM task_master WHERE id=@id", con);
            cmd.Parameters.AddWithValue("@id", id);
            con.Open();
            if (cmd.ExecuteNonQuery() > 0)
            {
                bindTaskData("bindData", null);
            }
            con.Close();
        }
    }
}