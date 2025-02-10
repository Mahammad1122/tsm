using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Net.Mail;
using System.IO;
namespace TaskManagement.config
{
   
    public class EmailService
    {
        private string SmtpServer = "smtp.gmail.com";  // Change for Outlook, Yahoo, etc.
        private int SmtpPort = 587;  // Gmail: 587 for TLS, 465 for SSL
        private string SenderEmail = "mahammadali2307@gmail.com";  // Change to your email
        private string SenderPassword = "rdmk jhpl cgpm rpwp"; // Use App Password for security


        /// Sends a simple email
        public string SendEmail(string toEmail, string subject, string body, bool isHtml = true)
        {
            try
            {
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress(SenderEmail);
                mail.To.Add(toEmail);
                mail.Subject = subject;
                mail.Body = body;
                mail.IsBodyHtml = isHtml; // Set to true for HTML email

                SmtpClient smtp = new SmtpClient(SmtpServer, SmtpPort)
                {
                    Credentials = new NetworkCredential(SenderEmail, SenderPassword),
                    EnableSsl = true
                };

                smtp.Send(mail);
                return "1";
            }
            catch (Exception ex)
            {
                return "Error sending email: " + ex.Message;
            }
        }

    }

}