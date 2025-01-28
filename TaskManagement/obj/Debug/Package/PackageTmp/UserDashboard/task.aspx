<%@ Page Title="" Language="C#" MasterPageFile="~/UserDashboard/Dashboard.Master" AutoEventWireup="true" CodeBehind="task.aspx.cs" Inherits="TaskManagement.Dashboard.task" Theme="User-Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="task-container">
        <div class="task-wrapper">
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
        <div class="tasks-operation">
            <div class="tasks-navigation">
                <asp:Button ID="btnApprove" CssClass="btn-task-navigation" Text="Approved" runat="server" />
                <asp:Button ID="btnPending" CssClass="btn-task-navigation" Text="Pending" runat="server" />
                <asp:Button ID="btnComplete" CssClass="btn-task-navigation" Text="Completed" runat="server" />
                <asp:Button ID="btnAssigned" CssClass="btn-task-navigation" Text="Assigned Task’s" runat="server" />                 
            </div>
            <div class="tasks-search">
                <asp:TextBox ID="txtTaskSearch" cssClass="input-search" runat="server" placeholder="Search Task" /> 
                <asp:Button ID="btnSearch" runat="server" cssClass="btn-search" Text="Search"/>
            </div>
        </div>
        <div class="all-task-wrapper">
            <span class="heading"> <asp:Label ID="lblTaskTitle" runat="server" Text="All Tasks" /></span> 
            <asp:Button ID="btnCreateTask" cssClass="btn-create-task" runat="server" 
                Text="Create Task" onclick="btnCreateTask_Click" />
        </div>
        <div class="all-task-display">
            <asp:MultiView ID="mvTask" runat="server" ActiveViewIndex="1">
                <asp:View ID="viewAllTask"  runat="server">
                    <div class="view-all-task">
                       
                    </div>
                </asp:View>
                <asp:View ID="viewCreateTask" runat="server">
                    <div class="form-container">
                        <div class="input-group">
                                <asp:Label ID="lblProjectName" runat="server" Text="Project Name" cssClass="label"/>
                                <asp:TextBox ID="txtProjectName" runat="server" cssClass="input" placeholder="Enter Project Name"/>
                        </div>
                        <div class="input-group">
                            <asp:Label ID="lblProjectDetails" runat="server" Text="Project Details" cssClass="label"/>
                            <asp:TextBox ID="txtProjectDetails" runat="server" TextMode="MultiLine" cssClass="input2" placeholder="Enter Details"/>
                        </div>
                        <div class="input-group">
                            <asp:Label ID="lblProjectDeadline" runat="server" Text="Project Deadline" cssClass="label"/>
                            <asp:TextBox ID="txtProjectDeadline" TextMode="Date" runat="server" cssClass="input"/>
                        </div>
                        <div class="input-group">
                            <asp:DropDownList ID="ddlProjectManager" runat="server" CssClass="drop-down">
                                <asp:ListItem>Select Project Manager</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="btn">
                            <asp:Button ID="btnTaskCreate" runat="server" CssClass="btn-create-task" Text="Create Task"/>
                        </div>
                    </div>
                </asp:View>
            </asp:MultiView>
        </div>
    </div>
</asp:Content>
