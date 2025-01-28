<%@ Page Title="" Language="C#" MasterPageFile="~/UserDashboard/Dashboard.Master" AutoEventWireup="true" CodeBehind="overview.aspx.cs" Inherits="TaskManagement.UserDashboard.overview" Theme="User-Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="overview-container">
         <div class="overview-wrapper">
            <div class="hi">
                <span class="user-name">
                    <asp:Label ID="lblUserName" runat="server" Text="User name"/>
                </span>
                <span class="information">
                    Let's finish your task today!
                </span>
            </div>
            <div class="profile">
            </div>
        </div>
        <div class="overview-operation">
            <div class="overview-navigation">
                <asp:Button ID="btnApprove" CssClass="btn-task-navigation" Text="Approved" runat="server" />
                <asp:Button ID="btnPending" CssClass="btn-task-navigation" Text="Pending" runat="server" />
                <asp:Button ID="btnComplete" CssClass="btn-task-navigation" Text="Completed" runat="server" />
                <asp:Button ID="btnAssigned" CssClass="btn-task-navigation" Text="Assigned Task’s" runat="server" />                 
            </div>
        </div>
        <div class="today-task-container">
            <div class="title">Today's Task</div>
            <div class="task">
                
            </div>
        </div>
        <div class="project-summary-container">
            <div class="wrapper">
                <span class="title">Project summary</span>
                <div class="project-ddl">
                    <asp:DropDownList ID="ddlProject" runat="server" cssClass="ddl" AutoPostBack="True" >
                        <asp:ListItem>Project</asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlProjectManager" runat="server" cssClass="ddl" AutoPostBack="True" >
                        <asp:ListItem>Project Manager</asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlProjectStatus" runat="server" cssClass="ddl" AutoPostBack="True" >
                        <asp:ListItem>Status</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="project-overview">

            </div>
        </div>
    </div>
</asp:Content>
