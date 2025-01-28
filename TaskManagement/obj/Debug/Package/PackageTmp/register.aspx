<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="TaskManagement.register" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
       <table>
            <tr>
                <th colspan="3"> Register </th>
            </tr>
            <tr>
                <td> Name: </td>
                <td> <asp:TextBox ID="txtName" runat="server"/> </td>
                <td> <asp:RequiredFieldValidator ID="requireUserName" runat="server" ErrorMessage="User name is Required" ForeColor="Red">*</asp:RequiredFieldValidator> </td>
            </tr> 
            <tr>
                <td> Email: </td>
                <td> <asp:TextBox ID="txtEmail" runat="server"/> </td>
                <td> 
                    <asp:RequiredFieldValidator ID="requireEmail" runat="server" ErrorMessage="Email is Required" ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="regexEmail" runat="server" ErrorMessage="Email is not valid" ForeColor="Red"></asp:RegularExpressionValidator>
                </td>
            </tr>
             <tr>
                <td> Password: </td>
                <td> <asp:TextBox ID="txtPassword" runat="server"/> </td>
                <td> <asp:RequiredFieldValidator ID="requirePassword" runat="server" ErrorMessage="Password is Required" ForeColor="Red">*</asp:RequiredFieldValidator> </td>
            </tr>
             <tr>
                <td> Confirm Password: </td>
                <td> <asp:TextBox ID="txtConfirmPassword" runat="server"/> </td>
                <td> <asp:CompareValidator ID="comparePassword" runat="server" ErrorMessage="Password not match" ForeColor="Red"></asp:CompareValidator> </td>
            </tr>
            <tr>
                <td></td>
                <td> <asp:Button ID="btnRegister" runat="server" Text="Register" /> </td>
                <td></td>
            </tr>
            <tr>
                <td colspan="3"> Already have an account? <asp:HyperLink  ID="hlLogin" runat="server" Text="Login" NavigateUrl="~/login.aspx" /> </td>
            </tr>
       </table>
    </div>
    </form>
</body>
</html>
