<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="TaskManagement.login" Theme="Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
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
                    <span>Log in to</span>
                    <span>Continue</span>
                </div>
                <asp:Label ID="lblAlert" runat="server" CssClass="label-alert" Text="Invalid Credentials" Visible="false"/>
                <div class="input-group">
                    <asp:Label ID="lblUserEmail" runat="server" Text="User email" CssClass="label" />
                    <asp:TextBox ID="txtUserEmail" runat="server" placeholder="Enter your email" CssClass="input" Required />
                </div>
                <div class="input-group">
                    <asp:Label ID="lblUserPassword" runat="server" Text="Password" CssClass="label" />
                    <asp:TextBox ID="txtUserPassword" runat="server" placeholder="Enter your password" TextMode="Password" CssClass="input" Required/>
                </div>
                <div class="user-option-wrapper">
                    <span><asp:CheckBox ID="chkRemember" runat="server"  Text="Remember me" /> </span>  
                    <asp:HyperLink ID="hlForgetPassword" NavigateUrl="~/ForgetPassword.aspx" runat="server" Text="Forget Password?" />
                </div>
                <div class="btn">
                    <asp:Button ID="btnLogin" CssClass="login-btn" runat="server" Text="Login" 
                        onclick="btnLogin_Click" />
                </div>
                <div class="register-wrapper">
                    Don't have an Account ? <asp:HyperLink ID="hlRegister" runat="server"  NavigateUrl="~/register.aspx"     Text="Register"/>
                </div>
            </div>
        </div>
    </div>
    </form>
    <script src="UserDashboard/js/jquery-3.7.1.min.js"></script>
    <script>
        if($(".label-alert").css("display") == "block"){
            setTimeout(()=>{
                $(".label-alert").fadeOut();
            },1500)
        }
    </script>
</body>
</html>
