<%@ Page Title="" Language="C#" MasterPageFile="~/UserDashboard/Dashboard.Master" AutoEventWireup="true" CodeBehind="overview.aspx.cs" Inherits="TaskManagement.UserDashboard.overview" Theme="User-Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
   <div class="overview-main-container">
        <div class="overview-container">
            <div class="overview-wrapper">
                <div class="hi">
                    <span class="user-name">
                        <asp:Label ID="lblUserName" runat="server"/>
                    </span>
                    <span class="information">
                        Let's finish your task today!
                    </span>
                </div>
                <div class="profile">
                    <svg class="notification-icon" width="30" height="30" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M19.3399 14.49L18.3399 12.83C18.1299 12.46 17.9399 11.76 17.9399 11.35V8.82C17.9399 6.47 16.5599 4.44 14.5699 3.49C14.0499 2.57 13.0899 2 11.9899 2C10.8999 2 9.91994 2.59 9.39994 3.52C7.44994 4.49 6.09994 6.5 6.09994 8.82V11.35C6.09994 11.76 5.90994 12.46 5.69994 12.82L4.68994 14.49C4.28994 15.16 4.19994 15.9 4.44994 16.58C4.68994 17.25 5.25994 17.77 5.99994 18.02C7.93994 18.68 9.97994 19 12.0199 19C14.0599 19 16.0999 18.68 18.0399 18.03C18.7399 17.8 19.2799 17.27 19.5399 16.58C19.7999 15.89 19.7299 15.13 19.3399 14.49Z" fill="#292D32"/>
                        <path d="M14.8297 20.01C14.4097 21.17 13.2997 22 11.9997 22C11.2097 22 10.4297 21.68 9.87969 21.11C9.55969 20.81 9.31969 20.41 9.17969 20C9.30969 20.02 9.43969 20.03 9.57969 20.05C9.80969 20.08 10.0497 20.11 10.2897 20.13C10.8597 20.18 11.4397 20.21 12.0197 20.21C12.5897 20.21 13.1597 20.18 13.7197 20.13C13.9297 20.11 14.1397 20.1 14.3397 20.07C14.4997 20.05 14.6597 20.03 14.8297 20.01Z" fill="#292D32"/>
                        </svg>
                        <div class="notification">
                            <span class="title">Notifications</span>
                            <hr>
                            <div class="notice-container">
                                <!-- <div class="card">
                                    <span class="msg-title">New Task Assigned</span>
                                    <span class="msg">create a admin panel</span>
                                </div> -->
                                <asp:Repeater ID="rpNotification" runat="server" 
                                    onitemcommand="rpNotification_ItemCommand" >
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lbNotification" CommandName="Click" CommandArgument='<%# Eval("id") %>' runat="server">
                                            <div class="card">
                                                <span class="msg-title"> <%# Eval("Title") %> </span>
                                                <span class="msg"> <%# Eval("Message") %> </span>
                                            </div>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                         <asp:Label ID="lblNoRecord" CssClass="label-no-record" runat="server" Text="No New Notifications" Visible='<%# rpNotification.Items.Count == 0 %>'></asp:Label>
                                    </FooterTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    <asp:Image ID="UserProfileImage"  runat="server" />
                </div>
            </div>
        <!-- <div class="overview-operation">
            <div class="overview-navigation">
                <asp:Button ID="btnApprove" CssClass="btn-task-navigation" Text="Approved" runat="server" />
                <asp:Button ID="btnPending" CssClass="btn-task-navigation" Text="Pending" runat="server" />
                <asp:Button ID="btnComplete" CssClass="btn-task-navigation" Text="Completed" runat="server" />
                <asp:Button ID="btnAssigned" CssClass="btn-task-navigation" Text="Assigned Task’s" runat="server" />                 
            </div>
        </div> -->
        <div class="today-task-container">
            <div class="title">Today's Task</div>
            <div class="task">
                <asp:Repeater ID="repeaterTask"  runat="server">
                    <ItemTemplate>
                        <div class="row">
                            <div class="box-1"> <asp:CheckBox ID="chkTask" runat="server" /> </div>
                            <div class="box-2"><asp:Label ID="lblTaskName" runat="server" Text='<%# Eval("task_name") %>'/></div>
                            <div class="box-3">
                                <span class="status"> <%# Eval("status") %></span>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
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
        <div class="side-container">
            <div class="card">
                <div class="title">Weekly Activity</div>
                <div class="data">
                    <div class="value">80%</div>
                    <div class="icon">
                        <svg width="35" height="32" viewBox="0 0 47 45" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" clip-rule="evenodd" d="M35.2854 37.6066L21.0586 23.3798V3.06667C21.0586 1.64914 22.2077 0.5 23.6253 0.5C25.0428 0.5 26.1919 1.64914 26.1919 3.06667V21.2535L38.9152 33.9768L46.1278 26.7642C46.3483 26.5437 46.7253 26.6998 46.7253 27.0116V43.7833C46.7253 43.9766 46.5686 44.1333 46.3753 44.1333H29.6036C29.2917 44.1333 29.1356 43.7563 29.3561 43.5359L35.2854 37.6066Z" fill="#5577FF"/>
                            <path fill-rule="evenodd" clip-rule="evenodd" d="M18.1512 43.5359C18.3717 43.7564 18.2155 44.1334 17.9037 44.1334H0.949609C0.75631 44.1334 0.599609 43.9767 0.599609 43.7834V26.8293C0.599609 26.5175 0.976609 26.3614 1.1971 26.5819L7.77782 33.1626L15.5507 26.5855L18.8665 30.5043L11.4202 36.805L18.1512 43.5359Z" fill="#5577FF"/>
                        </svg>    
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="title">Total tasks Completed</div>
                <div class="data">
                    <div class="value">40</div>
                    <div class="icon">
                        <svg width="35" height="38" viewBox="0 0 47 50" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" clip-rule="evenodd" d="M21.6556 15.5848C21.6697 15.4024 21.8217 15.2616 22.0046 15.2616H23.5513C23.7311 15.2616 23.8816 15.3978 23.8995 15.5768L24.9618 26.1991L32.4417 30.4733C32.5507 30.5356 32.618 30.6516 32.618 30.7772V32.3034C32.618 32.5341 32.3986 32.7017 32.1759 32.641L20.8658 29.5565C20.7039 29.5123 20.5961 29.3593 20.6089 29.1919L21.6556 15.5848Z" fill="#5577FF"/>
                            <path fill-rule="evenodd" clip-rule="evenodd" d="M11.3269 0.825258C11.142 0.604935 10.7851 0.689263 10.7184 0.969027L7.67501 13.728C7.62063 13.9559 7.80128 14.1719 8.03526 14.1586L21.1605 13.4148C21.4481 13.3985 21.594 13.0611 21.4088 12.8404L17.8503 8.59946C19.7613 7.94642 21.7878 7.60533 23.8687 7.60533C34.1377 7.60533 42.4624 15.93 42.4624 26.1991C42.4624 36.4681 34.1377 44.7928 23.8687 44.7928C13.5996 44.7928 5.2749 36.4681 5.2749 26.1991C5.2749 24.4752 5.50835 22.7867 5.96355 21.1639L1.75113 19.9823C1.19652 21.9596 0.899902 24.0447 0.899902 26.1991C0.899902 38.8844 11.1834 49.1678 23.8687 49.1678C36.5539 49.1678 46.8374 38.8844 46.8374 26.1991C46.8374 13.5138 36.5539 3.23033 23.8687 3.23033C20.6779 3.23033 17.639 3.88096 14.8776 5.05679L11.3269 0.825258Z" fill="#5577FF"/>
                        </svg>                            
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="title">Project Worked</div>
                <div class="data">
                    <div class="value">105</div>
                    <div class="icon">
                        <svg width="35" height="29" viewBox="0 0 46 40" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" clip-rule="evenodd" d="M3 36.65C3 37.2299 3.4701 37.7 4.05 37.7H42.55C43.1299 37.7 43.6 37.2299 43.6 36.65V9.92642C43.6 9.34652 43.1299 8.87642 42.55 8.87642H19.24L13.4584 3.01274C13.2611 2.81262 12.9918 2.69995 12.7107 2.69995H4.05C3.4701 2.69995 3 3.17005 3 3.74995V36.65Z" stroke="#5577FF" stroke-width="4.2"/>
                        </svg>
                    </div>
                </div>
            </div>
        </div>    
   </div>
   <script src="js/overview.js"></script>
</asp:Content>
