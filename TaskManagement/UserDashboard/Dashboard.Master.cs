using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TaskManagement.Dashboard
{
    public partial class Dashboard : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userId"] != null)
            {
                if (Convert.ToInt32(Session["userRole"]) == 1)
                {
                    if (menuUser.FindItem("Project") != null)
                    {
                        menuUser.Items.Remove(menuUser.FindItem("Project"));
                    }
                }
            }
        }
    }
}