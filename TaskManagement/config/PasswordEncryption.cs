﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Security.Cryptography;
using System.Text;

namespace TaskManagement.config
{
    public class PasswordEncryption
    {
        public static string HashPassword(string password)
        {
            using (var sha256 = SHA256.Create())
            {
                byte[] hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                return BitConverter.ToString(hashedBytes).Replace("-", "").ToLower();
            }
        }

        public static bool VerifyPassword(string enteredPassword, string storedHash)
        {
            string hashedEnteredPassword = HashPassword(enteredPassword);
            return hashedEnteredPassword == storedHash;
        }
    }
}