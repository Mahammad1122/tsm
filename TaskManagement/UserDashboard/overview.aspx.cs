using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace TaskManagement.UserDashboard
{
    public partial class overview : System.Web.UI.Page
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
            }
            if (!IsPostBack) {
                bindTodayTaskData();
            }
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
    }
}