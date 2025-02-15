<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgetPassword.aspx.cs" Inherits="TaskManagement.ForgetPassword" Theme="Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div class="main">
        <div class="header">
            <span class="logo">TM-SYSTEM</span>
        </div>
        <div class="container" style="height:90%;justify-content:center;padding-top:0px">
            <asp:MultiView ID="mvForm" runat="server" ActiveViewIndex="1">
                <asp:View ID="viewOtpSend" runat="server">
                    <div class="form-container">
                        <div class="continue-wrapper">
                            <span>Forget Password ?</span>
                            <span>Enter email to recieve OTP</span>
                        </div>
                        <asp:Label ID="lblEmailAlert" runat="server" CssClass="label-alert" Text="Email not exists" Visible="false"/>
                        <div class="input-group">
                            <%--<asp:Label ID="lblUserEmail" runat="server" Text="User email" CssClass="label" />--%>
                            <asp:TextBox ID="txtUserEmail" runat="server" placeholder="Enter your email" CssClass="input" Required />
                        </div>
                        <div class="btn">
                            <asp:Button ID="btnSendOtp" CssClass="login-btn" runat="server" Text="Send OTP" 
                                onclick="btnSendOtp_Click" />
                        </div>
                    </div>
                </asp:View>
                <asp:View ID="viewOtpVerify" runat="server">
                    <div class="form-container">
                        <div class="continue-wrapper">
                            <span>Verify OTP</span>
                            <span>Check mail inbox to get OTP</span>
                        </div>
                        <asp:Label ID="lblVerifyAlert" runat="server" CssClass="label-alert" Text="Otp is invalid" Visible="false"/>
                        <div class="input-group">
                            <%--<asp:Label ID="Label2" runat="server" Text="User email" CssClass="label" />--%>
                            <asp:TextBox ID="txtVerifyOtp" runat="server" placeholder="Enter OTP" CssClass="input" Required />
                        </div>
                        <div class="btn">
                            <asp:Button ID="btnVerifyOtp" CssClass="login-btn" runat="server" 
                                Text="Verify OTP" onclick="btnVerifyOtp_Click" />
                        </div>
                        <div class="register-wrapper" style="padding:0px;text-align:center;">
                            <asp:HyperLink ID="hlLogin" runat="server" NavigateUrl="~/login.aspx" Text="Back to login" />
                        </div>
                    </div>
                </asp:View>
                 <asp:View ID="viewNewPassword" runat="server">
                    <div class="form-container">
                        <div class="continue-wrapper">
                            <span>Reset password</span>
                        </div>
                        <asp:Label ID="lblResetAlert" runat="server" CssClass="label-alert" Text="Password Not Match" Visible="false"/>
                        <div class="input-group">
                            <asp:label id="lblNewPassword" runat="server" text="New password" cssclass="label" />
                            <asp:TextBox ID="txtNewPassword" runat="server" placeholder="Enter New Password" CssClass="input" Required />
                        </div>
                        <div class="input-group">
                            <asp:label id="lblConfirmPassword" runat="server" text="Confirm New password" cssclass="label" />
                            <asp:TextBox ID="txtConfirmPassword" runat="server" placeholder="Enter Confirm New Password" CssClass="input" Required />
                        </div>
                        <div class="btn">
                            <asp:Button ID="btnResetPassword" CssClass="login-btn" runat="server" 
                                Text="Reset Password" onclick="btnResetPassword_Click" />
                        </div>
                    </div>
                </asp:View>
            </asp:MultiView>
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
