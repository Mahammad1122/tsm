<%@ Page Title="" Language="C#" MasterPageFile="~/UserDashboard/Dashboard.Master" AutoEventWireup="true" CodeBehind="task.aspx.cs" Inherits="TaskManagement.Dashboard.task" Theme="User-Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Task</title>
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
                <asp:Button ID="btnInProgress" CssClass="btn-task-navigation" Text="In Progress" runat="server" onclick="taskFilterStatus"/>
                <asp:Button ID="btnPending" CssClass="btn-task-navigation" Text="Pending" runat="server" onclick="taskFilterStatus" />
                <asp:Button ID="btnComplete" CssClass="btn-task-navigation" Text="Completed" runat="server" onclick="taskFilterStatus" />
                <asp:Button ID="btnAssigned" CssClass="btn-task-navigation" Text="Assigned" runat="server" onclick="taskFilterStatus"/>                 
            </div>
            <div class="tasks-search">
                <asp:TextBox ID="txtTaskSearch" cssClass="input-search" runat="server" placeholder="Search Task" /> 
                <asp:Button ID="btnSearch" runat="server" cssClass="btn-search" Text="Search" 
                    onclick="btnSearch_Click"/>
                <div class="priority-btn-container">
                    <asp:Button ID="btnNormal" CssClass="btn-priority" Text="Normal" runat="server" onclick="taskFilterStatus"/>
                    <asp:Button ID="btnMedium" CssClass="btn-priority" Text="Medium" runat="server" onclick="taskFilterStatus"/>
                    <asp:Button ID="btnHigh" CssClass="btn-priority" Text="High" runat="server" onclick="taskFilterStatus"/>
                </div>
            </div>
        </div>
        <div class="all-task-wrapper">
            <span class="heading"> <asp:Label ID="lblTaskTitle" runat="server" Text="All Tasks" /></span> 
            <asp:Button ID="btnCreateTask" cssClass="btn-create-task" runat="server" 
                Text="Create Task" onclick="btnCreateTask_Click" />
        </div>
        <div class="all-task-display">
            <asp:MultiView ID="mvTask" runat="server" ActiveViewIndex="0" 
                onactiveviewchanged="mvTask_ActiveViewChanged">
                <asp:View ID="viewAllTask"  runat="server">
                    <div class="view-all-task">
                        <asp:DataList ID="dlTask" DataKeyField="id" runat="server" RepeatDirection="Vertical" 
                            RepeatLayout="Flow" oneditcommand="dlTask_EditCommand" 
                            ondeletecommand="dlTask_DeleteCommand" >
                            <HeaderTemplate>
                                <div class="table" >
                                    <div class="task-row row header">
                                        <div class="col"></div>
                                        <div class="col">Task Name</div>
                                        <div class="col">Priority</div>
                                        <div class="col">Task Created</div>
                                        <div class="col">Due Date</div>
                                        <div class="col">Last Activity</div>
                                        <div class="col">Status</div>
                                    </div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                    <div class="task-row row" >
                                        <div class="col">
                                            <asp:CheckBox ID="chkTask" runat="server" Text='<%# Eval("id") %>' CssClass="checkbox"/>
                                        </div>
                                        <div class="col"> <asp:Label ID="lblTaskName" runat="server" Text='<%# Eval("task_name") %>' /> </div>
                                        <div class="col"> <asp:Label ID="lblTaskPriority" CssClass="priority" runat="server" Text='<%# Eval("priority") %>' /> </div>
                                        <div class="col"> <asp:Label ID="lblTaskCreated" runat="server" Text='<%# Eval("created_at", "{0:MMM d, yyyy}")%>' /> </div>
                                        <div class="col"> <asp:Label ID="lblTaskDueDate" runat="server" Text='<%# Eval("due_date", "{0:MMM d, yyyy}")%>' /> </div>
                                        <div class="col"> <asp:Label ID="lblTaskModifiedDate" runat="server" Text='<%# Eval("modified_at","{0:MMM d, yyyy}")%>' /> </div>
                                        <div class="col"> <asp:Label ID="lblTaskStatus" CssClass="status" runat="server" Text='<%# Eval("status") %>' /> </div>
                                    </div>
                                    <div class="task-row2 row2" id='<%# Eval("id") %>'>
                                        <div class="col"> <asp:Label ID="lblTaskDescription" runat="server" Text='<%# Eval("description") %>' /> </div>
                                        <div class="col"> 
                                            <asp:Button ID="btnEditTask" runat="server" Text="Edit Task" 
                                            CssClass="btn edit-btn" CommandName="Edit" />
                                            <asp:Button 
                                                    ID="btnDeleteTask" runat="server" Text="Delete Task" CssClass="btn delete-btn" CommandName="Delete" OnClientClick="return showConfirm()" />   
                                        </div>
                                    </div>
                            </ItemTemplate>
                            <FooterTemplate>
                                </div>
                                <asp:Label ID="lblNoRecord" CssClass="label-no-record" runat="server" Text="No records found!" Visible='<%# dlTask.Items.Count == 0 %>'></asp:Label>
                            </FooterTemplate>
                        </asp:DataList>                    
                    </div>
                </asp:View>
                <asp:View ID="viewCreateTask" runat="server">
                    <div class="form-container">
                        <div class="input-group">
                                <asp:Label ID="lblTaskName" runat="server" Text="Task Name" cssClass="label">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtTaskName" runat="server" ValidationGroup="taskCreateValidation"  ErrorMessage="* Task name can't be null" ForeColor="Red" Font-Size="13px"/>
                                </asp:Label><asp:TextBox ID="txtTaskName" runat="server" cssClass="input" placeholder="Enter Task Name"/>
                                
                        </div>
                        <div class="input-group">
                            <asp:Label ID="lblTaskDetails" runat="server" Text="Task Details" cssClass="label">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtTaskDetails" runat="server" ValidationGroup="taskCreateValidation" ErrorMessage="* Task details can't be null" ForeColor="Red" Font-Size="13px" />
                            </asp:Label><asp:TextBox ID="txtTaskDetails" runat="server" TextMode="MultiLine" cssClass="input2" placeholder="Enter Details"/>
                            
                        </div>
                        <div class="input-group">
                            <asp:Label ID="lblTaskDeadline" runat="server" Text="Task Deadline" cssClass="label">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtTaskDeadline" runat="server" ValidationGroup="taskCreateValidation" ErrorMessage="* Please select task details" ForeColor="Red" Font-Size="13px"/>                                
                            </asp:Label><asp:TextBox ID="txtTaskDeadline" TextMode="Date" runat="server" cssClass="input"/>
                        </div>
                        <div class="input-group">
                            <asp:Label ID="lblTaskPriority" runat="server" Text="Task Priority" cssClass="label">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="ddlTaskPriority" runat="server" ValidationGroup="taskCreateValidation" ErrorMessage="* Please select task priority" ForeColor="Red" Font-Size="13px"/>                                                            
                            </asp:Label><asp:DropDownList ID="ddlTaskPriority" runat="server" CssClass="drop-down">
                                <asp:ListItem value="">- - - Select Priority - - -</asp:ListItem><asp:ListItem value="High">High</asp:ListItem><asp:ListItem value="Medium">Medium</asp:ListItem><asp:ListItem value="Normal">Normal</asp:ListItem></asp:DropDownList></div><div class="btn">
                            <asp:Button 
                                ID="btnTaskCreate" ValidationGroup="taskCreateValidation" runat="server" CssClass="btn-create-task" 
                                Text="Create Task" onclick="btnTaskCreate_Click"/></div>
                    </div>
                </asp:View>
                  <asp:View ID="viewEditTask" runat="server">
                    <div class="form-container">
                         <asp:HiddenField ID="hfTaskId" runat="server" />
                        <div class="input-group">
                                <asp:Label ID="lblEditTaskName" runat="server" Text="Task Name" cssClass="label">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="txtEditTaskName" runat="server" ValidationGroup="taskEditValidation"  ErrorMessage="* Task name can't be null" ForeColor="Red" Font-Size="13px"/>                                    
                                </asp:Label><asp:TextBox ID="txtEditTaskName" runat="server" cssClass="input" placeholder="Enter Task Name"/>
                        </div>
                        <div class="input-group">
                            <asp:Label ID="lblEditTaskDetails" runat="server" Text="Task Details" cssClass="label">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ControlToValidate="txtEditTaskDetails" runat="server" ValidationGroup="taskEditValidation" ErrorMessage="* Task details can't be null" ForeColor="Red" Font-Size="13px" />                                
                            </asp:Label><asp:TextBox ID="txtEditTaskDetails" runat="server" TextMode="MultiLine" cssClass="input2" placeholder="Enter Details"/>
                        </div>
                        <div class="input-group">
                            <asp:Label ID="lblEditTaskDeadline" runat="server" Text="Task Deadline" cssClass="label">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ControlToValidate="txtEditTaskDeadline" runat="server" ValidationGroup="taskEditValidation" ErrorMessage="* Please select task details" ForeColor="Red" Font-Size="13px"/>                                                                
                            </asp:Label><asp:TextBox ID="txtEditTaskDeadline" TextMode="Date" runat="server" cssClass="input"/>
                        </div>
                        <div class="input-group">
                            <asp:Label ID="lblEditTaskPriority" runat="server" Text="Task Priority" cssClass="label">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ControlToValidate="ddlEditTaskPriority" runat="server" ValidationGroup="taskDditValidation" ErrorMessage="* Please select task priority" ForeColor="Red" Font-Size="13px"/>                                                                                        
                            </asp:Label><asp:DropDownList ID="ddlEditTaskPriority" runat="server" CssClass="drop-down">
                                <asp:ListItem value="">- - - Select Priority - - -</asp:ListItem><asp:ListItem value="High">High</asp:ListItem><asp:ListItem value="Medium">Medium</asp:ListItem><asp:ListItem value="Normal">Normal</asp:ListItem></asp:DropDownList></div><div class="input-group">
                            <asp:Label ID="lblEditTaskStatus" runat="server" Text="Task Status" cssClass="label">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ControlToValidate="ddlEditTaskStatus" runat="server" ValidationGroup="taskEditValidation" ErrorMessage="* Please select task Status" ForeColor="Red" Font-Size="13px"/>                                                                                            
                            </asp:Label><asp:DropDownList ID="ddlEditTaskStatus" runat="server" CssClass="drop-down">
                                <asp:ListItem value="">- - - Select Status - - -</asp:ListItem><asp:ListItem value="In Progress">In Progress</asp:ListItem><asp:ListItem value="Pending">Pending</asp:ListItem><asp:ListItem value="Completed">Completed</asp:ListItem></asp:DropDownList></div><div class="btn">
                            <asp:Button 
                                 ID="btnUpdate" runat="server" CssClass="btn-create-task" Text="Update Task" ValidationGroup="taskEditValidation"
                                 onclick="btnUpdate_Click"/>
                                  <asp:Button ID="btnCancelUpdate" runat="server" 
                                 CssClass="btn-cancel-task" Text="Cancel" onclick="btnCancelUpdate_Click" /></div>
                    </div>
                </asp:View>
            </asp:MultiView> 
        </div>
    </div>
    <!-- <script src="js/jquery-3.7.1.min.js" type="text/javascript"></script> -->
    <script src="js/task.js" type="text/javascript"></script>
</asp:Content>
