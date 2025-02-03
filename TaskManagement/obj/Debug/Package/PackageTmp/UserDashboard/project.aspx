<%@ Page Title="" Language="C#" MasterPageFile="~/UserDashboard/Dashboard.Master" AutoEventWireup="true" CodeBehind="project.aspx.cs" Inherits="TaskManagement.Dashboard.project" Theme="User-Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Project</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="task-container">
        <div class="task-wrapper">
            <div class="hi">
                <span class="user-name">
                    <asp:Label ID="lblUserName" runat="server" Text="User name"/>
                </span>
                <span class="information">
                    Let's finish your project today!
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
                <!-- <asp:Button ID="btnAssigned" CssClass="btn-task-navigation" Text="Assigned" runat="server" onclick="taskFilterStatus"/>                  -->
            </div>
            <div class="tasks-search">
                <asp:TextBox ID="txtTaskSearch" cssClass="input-search" runat="server" placeholder="Search Project" /> 
                <asp:Button ID="btnSearch" runat="server" cssClass="btn-search" Text="Search" 
                    onclick="btnSearch_Click"/>
            </div>
        </div>
        <div class="all-task-wrapper">
            <span class="heading"> <asp:Label ID="lblTaskTitle" runat="server" Text="All Projects" /></span> 
            <asp:Button ID="btnCreateTask" cssClass="btn-create-task" runat="server" 
                Text="Create Task" onclick="btnCreateTask_Click" />
        </div>
        <div class="all-task-display">
            <asp:MultiView ID="mvTask" runat="server" ActiveViewIndex="0" 
                onactiveviewchanged="mvTask_ActiveViewChanged">
                <asp:View ID="viewAllTask"  runat="server">
                    <div class="view-all-task">
                        <asp:DataList ID="dlProject" DataKeyField="id" runat="server" RepeatDirection="Vertical" 
                            RepeatLayout="Flow" oneditcommand="dlTask_EditCommand" 
                            ondeletecommand="dlTask_DeleteCommand" >
                            <HeaderTemplate>
                                <div class="table" >
                                    <div class="project-row row header ">
                                        <div class="col"></div>
                                        <div class="col">Project Name</div>
                                        <div class="col">Project Created</div>
                                        <div class="col">Due Date</div>
                                        <div class="col">Status</div>
                                    </div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                    <div class="project-row row" >
                                        <div class="col">
                                            <asp:CheckBox ID="chkProject" runat="server" Text='<%# Eval("id") %>' CssClass="checkbox"/>
                                        </div>
                                        <div class="col"> <asp:HyperLink ID="hlProjectName" runat="server" Text='<%# Eval("project_name") %>' NavigateUrl='<%# "~/UserDashboard/ProjectTask.aspx?project_id="+Eval("id") %>'/>  </div>
                                        <div class="col"> <asp:Label ID="lblProjectCreated" runat="server" Text='<%# Eval("start_date", "{0:MMM d, yyyy}")%>' /> </div>
                                        <div class="col"> <asp:Label ID="lblProjectDueDate" runat="server" Text='<%# Eval("end_date", "{0:MMM d, yyyy}")%>' /> </div>
                                        <div class="col"> <asp:Label ID="lblProjectStatus" CssClass="status" runat="server" Text='<%# Eval("status") %>' /> </div>
                                    </div>      
                                    <div class="project-row2 row2" id='<%# Eval("id") %>'>
                                        <div class="col"> <asp:Label ID="lblProjectDescription" runat="server" Text='<%# Eval("description") %>' /> </div>
                                        <div class="col"> 
                                            <asp:Button ID="btnEditProject" runat="server" Text="Edit Project" 
                                            CssClass="btn edit-btn" CommandName="Edit" />
                                            <asp:Button 
                                                    ID="btnDeleteProject" runat="server" Text="Delete Project" CssClass="btn delete-btn" CommandName="Delete" OnClientClick="return showConfirm()" />   
                                        </div>
                                    </div>
                            </ItemTemplate>
                            <FooterTemplate>
                                </div>
                                <asp:Label ID="lblNoRecord" CssClass="label-no-record" runat="server" Text="No records found!" Visible='<%# dlProject.Items.Count == 0 %>'></asp:Label>
                            </FooterTemplate>
                        </asp:DataList>                    
                    </div>
                </asp:View>
                <asp:View ID="viewCreateTask" runat="server">
                    <div class="form-container">
                        <div class="input-group">
                                <asp:Label ID="lblProjectName" runat="server" Text="Project Name" cssClass="label">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtProjectName" runat="server" ValidationGroup="taskCreateValidation"  ErrorMessage="* Task name can't be null" ForeColor="Red" Font-Size="13px"/>
                                </asp:Label><asp:TextBox ID="txtProjectName" runat="server" cssClass="input" placeholder="Enter Project Name"/>
                                
                        </div>
                        <div class="input-group">
                            <asp:Label ID="lblProjectDetails" runat="server" Text="Project Details" cssClass="label">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtProjectDetails" runat="server" ValidationGroup="taskCreateValidation" ErrorMessage="* Task details can't be null" ForeColor="Red" Font-Size="13px" />
                            </asp:Label><asp:TextBox ID="txtProjectDetails" runat="server" TextMode="MultiLine" cssClass="input2" placeholder="Enter Details"/>
                            
                        </div>
                        <div class="input-group">
                            <asp:Label ID="lblProjectDeadline" runat="server" Text="Project Deadline" cssClass="label">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtProjectDeadline" runat="server" ValidationGroup="taskCreateValidation" ErrorMessage="* Please select task details" ForeColor="Red" Font-Size="13px"/>                                
                            </asp:Label><asp:TextBox ID="txtProjectDeadline" TextMode="Date" runat="server" cssClass="input"/>
                        </div>
                        <div class="btn">
                            <asp:Button 
                                ID="btnTaskCreate" ValidationGroup="taskCreateValidation" runat="server" CssClass="btn-create-task" 
                                Text="Create Project" onclick="btnTaskCreate_Click"/>
                        </div>
                    </div>
                </asp:View>
                  <asp:View ID="viewEditTask" runat="server">
                    <div class="form-container">
                         <asp:HiddenField ID="hfProjectId" runat="server" />
                        <div class="input-group">
                                <asp:Label ID="lblEditProjectName" runat="server" Text="Project Name" cssClass="label">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="txtEditProjectName" runat="server" ValidationGroup="taskEditValidation"  ErrorMessage="* Task name can't be null" ForeColor="Red" Font-Size="13px"/>                                    
                                </asp:Label><asp:TextBox ID="txtEditProjectName" runat="server" cssClass="input" placeholder="Enter Project Name"/>
                        </div>
                        <div class="input-group">
                            <asp:Label ID="lblEditProjectDetails" runat="server" Text="Project Details" cssClass="label">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ControlToValidate="txtEditProjectDetails" runat="server" ValidationGroup="taskEditValidation" ErrorMessage="* Task details can't be null" ForeColor="Red" Font-Size="13px" />                                
                            </asp:Label><asp:TextBox ID="txtEditProjectDetails" runat="server" TextMode="MultiLine" cssClass="input2" placeholder="Enter Details"/>
                        </div>
                        <div class="input-group">
                            <asp:Label ID="lblEditProjectDeadline" runat="server" Text="Project Deadline" cssClass="label">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ControlToValidate="txtEditProjectDeadline" runat="server" ValidationGroup="taskEditValidation" ErrorMessage="* Please select task details" ForeColor="Red" Font-Size="13px"/>                                                                
                            </asp:Label><asp:TextBox ID="txtEditProjectDeadline" TextMode="Date" runat="server" cssClass="input"/>
                        </div>
                        <div class="input-group">
                            <asp:Label ID="lblEditProjectStatus" runat="server" Text="Project Status" cssClass="label">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ControlToValidate="ddlEditProjectStatus" runat="server" ValidationGroup="taskEditValidation" ErrorMessage="* Please select task Status" ForeColor="Red" Font-Size="13px"/>                                                                                            
                            </asp:Label><asp:DropDownList ID="ddlEditProjectStatus" runat="server" CssClass="drop-down">
                                <asp:ListItem value="">- - - Select Status - - -</asp:ListItem><asp:ListItem value="In Progress">In Progress</asp:ListItem><asp:ListItem value="Pending">Pending</asp:ListItem><asp:ListItem value="Completed">Completed</asp:ListItem></asp:DropDownList></div><div class="btn">
                            <asp:Button 
                                 ID="btnUpdate" runat="server" CssClass="btn-create-task" Text="Update Project" ValidationGroup="taskEditValidation"
                                 onclick="btnUpdate_Click"/>
                            <asp:Button ID="btnCancelUpdate" runat="server" 
                                 CssClass="btn-cancel-task" Text="Cancel" onclick="btnCancelUpdate_Click" /></div>
                    </div>
                </asp:View>
            </asp:MultiView> 
        </div>
    </div>
    <script src="js/project.js" type="text/javascript"></script>
</asp:Content>
