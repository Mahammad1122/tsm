using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
namespace TaskManagement.config
{
    public class Notification
    {
        static string conStr = ConfigurationManager.ConnectionStrings["taskManagementDB"].ConnectionString;
        private SqlConnection con = new SqlConnection(conStr);
        public int sendNotification(int userId,string type,string message)
        {
            string title = null;
            if (type == "task")
            {
                title = "New Task Assigned";
            }
            if(type == "reminder")
            {
                title = "Task Due Reminder";
            }
            if (type == "projectReminder")
            {
                title = "Project Due Reminder";
                type = "reminder";
            }
            SqlCommand cmd = new SqlCommand("INSERT INTO Notifications (UserId, Title, Message, Type, IsRead, CreatedAt) SELECT @UserId, @Title, @Message, @Type, 0, GETDATE() WHERE NOT EXISTS (SELECT 1 FROM Notifications WHERE UserId = @UserId AND Title = @Title AND Message = @Message AND CAST(CreatedAt AS DATE) = CAST(GETDATE() AS DATE))",con);
            cmd.Parameters.AddWithValue("@UserId",userId);
            cmd.Parameters.AddWithValue("@Title",title);
            cmd.Parameters.AddWithValue("@Message", message);
            cmd.Parameters.AddWithValue("@type",type);
            con.Open();
            if (cmd.ExecuteNonQuery() > 0)
            {
                con.Close();
                return 1;
            }
            else {
                con.Close();
                return 0;
            }
        }
        public DataSet ReceiveNotification(int userId)
        {
            SqlCommand cmd = new SqlCommand("SELECT * FROM Notifications WHERE UserId = @userId AND IsRead = 0 ORDER BY CreatedAt DESC",con);
            cmd.Parameters.AddWithValue("@userId", userId);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            return ds;
        }
        public int readNotification(int notificationId) 
        {
            SqlCommand cmd = new SqlCommand("UPDATE Notifications SET IsRead = 1 WHERE id = @Id",con);
            cmd.Parameters.AddWithValue("@Id", notificationId);
            con.Open();
            if (cmd.ExecuteNonQuery() > 0)
            {
                con.Close();
                return 1;
            }
            else
            {
                return 0;
            }
            con.Close();
        }
    }
}