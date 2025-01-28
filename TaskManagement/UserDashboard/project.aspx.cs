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
    public partial class project : System.Web.UI.Page
    {
        private static string strCon = ConfigurationManager.ConnectionStrings["taskManagementDB"].ConnectionString;
        SqlConnection con = new SqlConnection(strCon);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userId"] == null)
            {
                Response.Redirect("../login.aspx");
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
                cmd = new SqlCommand("SELECT * FROM projects WHERE created_by_user = @userId ORDER BY id DESC", con);
                cmd.Parameters.AddWithValue("@userId",Session["userId"]);
            }
            else if (operation == "taskSearch")
            {
                cmd = new SqlCommand("SELECT * FROM projects WHERE (created_by_user = @userId) AND (project_name LIKE '%'+@search+'%' OR status LIKE '%'+@search+'%') ORDER BY id DESC", con);
                cmd.Parameters.AddWithValue("@search", value);
                cmd.Parameters.AddWithValue("@userId", Session["userId"]);

            }
            else if (operation == "statusFilter")
            {
                cmd = new SqlCommand("SELECT * FROM projects WHERE (created_by_user = @userId) AND status =@status ORDER BY id DESC", con);
                cmd.Parameters.AddWithValue("@status", value);
                cmd.Parameters.AddWithValue("@userId", Session["userId"]);      
            }
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            dlProject.DataSource = ds;
            dlProject.DataBind();
        }
        protected void btnTaskCreate_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("INSERT INTO projects VALUES(@project_name,@description,@created_at,@due_date,@status,@created_by_user)",con);
            cmd.Parameters.AddWithValue("@project_name",txtProjectName.Text);
            cmd.Parameters.AddWithValue("@description", txtProjectDetails.Text);
            cmd.Parameters.AddWithValue("@due_date", txtProjectDeadline.Text);
            cmd.Parameters.AddWithValue("@status","In Progress");
            cmd.Parameters.AddWithValue("@created_by_user", Convert.ToInt32(Session["userId"]));
            cmd.Parameters.AddWithValue("@created_at",DateTime.Now.ToShortDateString());
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
                lblTaskTitle.Text = "All Projects ";    
                btnCreateTask.Text = "Create Project";
                btnCreateTask.Visible = true;
            }
            else if (mvTask.ActiveViewIndex == 1)
            {
                lblTaskTitle.Text = "Create Project ";
                btnCreateTask.Text = "All Projects";
                btnCreateTask.Visible = true;
            }
            else if (mvTask.ActiveViewIndex == 2)
            {
                lblTaskTitle.Text = "Update Project ";
                btnCreateTask.Visible = false;
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("UPDATE projects SET project_name= @project_name, description = @description, end_date= @due_date, status = @status WHERE id = @id",con);
            cmd.Parameters.AddWithValue("@id", hfProjectId.Value);
            cmd.Parameters.AddWithValue("@project_name", txtEditProjectName.Text);
            cmd.Parameters.AddWithValue("@description",txtEditProjectDetails.Text);
            cmd.Parameters.AddWithValue("@due_date", txtEditProjectDeadline.Text);
            cmd.Parameters.AddWithValue("@status",ddlEditProjectStatus.SelectedValue);
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
                    lblTaskTitle.Text = btnFilter.Text + " Project ";
                    btnCount = 0;
                }
                else if (btnText == btnFilter.Text && btnCount < 1)
                {
                    lblTaskTitle.Text = "All Project ";
                    bindTaskData("bindData", null);
                    btnCount++;
                }
                else{
                    btnText = btnFilter.Text;
                    lblTaskTitle.Text = btnFilter.Text + " Project ";
                    bindTaskData("statusFilter", btnFilter.Text);
                    btnCount = 0;
                }
            }
        }

        protected void dlTask_EditCommand(object source, DataListCommandEventArgs e)
        {
            DataListItem item = e.Item;
            hfProjectId.Value = (item.FindControl("chkProject") as CheckBox).Text;
            txtEditProjectName.Text = (item.FindControl("lblProjectName") as Label).Text;
            txtEditProjectDetails.Text = (item.FindControl("lblProjectDescription") as Label).Text;
            DateTime taskDueDate = Convert.ToDateTime((item.FindControl("lblProjectDueDate") as Label).Text);
            txtEditProjectDeadline.Text = taskDueDate.ToString("yyyy-MM-dd");
            ddlEditProjectStatus.SelectedValue = (item.FindControl("lblProjectStatus") as Label).Text;
            mvTask.ActiveViewIndex = 2;
        }

        protected void dlTask_DeleteCommand(object source, DataListCommandEventArgs e)
        {
            int id  = Convert.ToInt32((e.Item.FindControl("chkProject") as CheckBox).Text);
            SqlCommand cmd = new SqlCommand("DELETE FROM projects WHERE id=@id", con);
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