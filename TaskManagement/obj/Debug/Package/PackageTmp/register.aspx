﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="TaskManagement.register" Theme="Register"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register</title>
    <link rel="icon" type="image/x-icon" href="/icon/icon3.png"/>
</head>
<body>
    <form id="form1" runat="server">
        <div class="main">
            <div class="header">
                <span class="logo">TM-SYSTEM</span>
            </div>
            <div class="container">
                <div class="form-container">
                    
                    <div class="welcome-wrapper">Welcome !</div>
                    <div class="continue-wrapper">
                        <span>Sign up to</span>
                        <span>Continue</span>
                    </div>
                    <asp:Label ID="lblAlert" runat="server" CssClass="label-alert"  Visible="false"/>
                    <div class="validation-summary">
                        <asp:ValidationSummary ID="ValidationSummary1" CssClass="summary" runat="server" />
                    </div>
                    <div class="input-group">
                        <asp:Label ID="lblUserName" runat="server" Text="User Name" CssClass="label" />
                        <asp:TextBox ID="txtUserName" runat="server" placeholder="Enter your Name" CssClass="input" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="input-validation" ControlToValidate="txtUserName" runat="server" ErrorMessage="Name Can't be null" ForeColor="Red">*</asp:RequiredFieldValidator>
                    </div>
                    <div class="input-group">
                        <asp:Label ID="lblUserEmail" runat="server" Text="User Email" CssClass="label" />
                        <asp:TextBox ID="txtUserEmail" TextMode="Email" runat="server" placeholder="Enter your E-mail" CssClass="input" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtUserEmail" CssClass="input-validation" runat="server" ErrorMessage="Email can't be null">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" 
                            CssClass="input-validation" ControlToValidate="txtUserEmail" runat="server" 
                            ErrorMessage="Invalid e-mail format" 
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
                    </div>
                    <div class="input-group">
                        <asp:Label ID="lblUserPassword" runat="server" Text="Password" CssClass="label" />
                        <asp:TextBox ID="txtUserPassword" TextMode="Password" runat="server" placeholder="Enter your password" CssClass="input" ToolTip="Enter 8 or more character for password" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtUserPassword" CssClass="input-validation" runat="server" ErrorMessage="Password can't be null">*</asp:RequiredFieldValidator>
                    </div>
                    <div class="input-group">
                        <asp:Label ID="lblUserConfirmPassword" runat="server" Text="Confirm Password" CssClass="label" />
                        <asp:TextBox ID="txtUserConfirmPassword" runat="server" TextMode="Password" placeholder="Enter your Confirm password" CssClass="input" />
                        <asp:CompareValidator ID="CompareValidator1" CssClass="input-validation" ControlToValidate="txtUserConfirmPassword" ControlToCompare="txtUserPassword" runat="server" ErrorMessage="Password must be same">*</asp:CompareValidator>
                    </div>
                    <div class="input-group">
                        <asp:Label ID="lblUserRole" runat="server" Text="User Role" CssClass="label" />
                        <asp:DropDownList ID="ddlUserRole" runat="server" cssClass="input" Height="32px" Width="258px">
                            <asp:ListItem Value="">- - - Select Role - - -</asp:ListItem>
                            <asp:ListItem Value="0">Project Manager</asp:ListItem>
                            <asp:ListItem Value="1">Employee</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="ddlUserRole" CssClass="input-validation" runat="server" ErrorMessage="Select user role">*</asp:RequiredFieldValidator>
                    </div>
                    <div class="input-group">
                        <asp:Label ID="lblUserImage" runat="server" Text="User Image" cssClass="label"/>
                        <asp:Label ID="lblFileUpload" runat="server" Text="No file chosen" AssociatedControlID="fuUserImage" cssClass="input-file-label"/>
                        <asp:FileUpload ID="fuUserImage" runat="server"  cssClass="input-file"/>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="fuUserImage" runat="server" CssClass="input-validation" ErrorMessage="Select User Image">*</asp:RequiredFieldValidator>
                    </div>
                    <div class="btn">
                        <asp:Button ID="btnRegister" CssClass="register-btn" runat="server" 
                            Text="Register" onclick="btnRegister_Click" />
                    </div>
                    <div class="login-wrapper">
                       Do you have an Account ? <asp:HyperLink ID="hlLogin" runat="server"  NavigateUrl="~/login.aspx" Text="Login"/>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="UserDashboard/js/jquery-3.7.1.min.js"></script>
    <script>
        $('#fuUserImage').on('change',function (e) { 
            console.log(e)
            const file = e.target.files[0];
            if(file){
                $('.input-file-label').text(file.name);
            }
            else{
                $('.input-file-label').text("No file chosen");
            }
        });
        if($(".label-alert").css("display") == "block"){
            setTimeout(()=>{
                $(".label-alert").fadeOut();
            },1500)
        }
    </script>
</body>
</html>
