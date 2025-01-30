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

        /// <summary>
        /// Sends a simple email
        /// </summary>
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

        /// <summary>
        /// Sends an email with an attachment
        /// </summary>
        public string SendEmailWithAttachment(string toEmail, string subject, string body, string attachmentPath, bool isHtml = true)
        {
            try
            {
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress(SenderEmail);
                mail.To.Add(toEmail);
                mail.Subject = subject;
                mail.Body = body;
                mail.IsBodyHtml = isHtml;

                // Add attachment if file exists
                if (File.Exists(attachmentPath))
                {
                    Attachment attachment = new Attachment(attachmentPath);
                    mail.Attachments.Add(attachment);
                }
                else
                {
                    return "Error: Attachment file not found.";
                }

                SmtpClient smtp = new SmtpClient(SmtpServer, SmtpPort)
                {
                    Credentials = new NetworkCredential(SenderEmail, SenderPassword),
                    EnableSsl = true
                };

                smtp.Send(mail);
                return "Email with attachment sent successfully!";
            }
            catch (Exception ex)
            {
                return "Error sending email with attachment: " + ex.Message;
            }
        }
    }

}