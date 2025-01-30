<%@ Page Title="" Language="C#" MasterPageFile="~/UserDashboard/Dashboard.Master" AutoEventWireup="true" CodeBehind="message.aspx.cs" Inherits="TaskManagement.UserDashboard.message" Theme="User-Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="message-dashboard">
        <div class="user-container">
            <asp:TextBox ID="txtSearch" runat="server" cssClass="input-search" placeholder="Search Name"/>
            <hr/>
            <!-- <div class="user">
                <div class="user-img">
                    <img src="" alt="">
                </div>
                <div class="user-name">Marshal</div>
            </div> -->
            <asp:Repeater ID="rpUser" runat="server" onitemcommand="rpUser_ItemCommand" >
                <ItemTemplate>
                    <div class="user">
                    <asp:LinkButton ID="lbChatOpen" CommandName="Click" CommandArgument='<%# Eval("id")+"|"+Eval("name")+"|"+Eval("img_url") %>' CssClass="link-user" runat="server">
                    <div class="user-img">
                        <asp:Image ID="userProfileIamge" ImageUrl='<%# Eval("img_url") %>' runat="server" />
                    </div>
                    <div class="user-name"><asp:Label ID="lblUserName" runat="server" Text='<%# Eval("name") %>'/></div>
                    </asp:LinkButton></div></ItemTemplate></asp:Repeater>
            </div>
            <div class="blank-container">
                    <span>Select chat to start conversation.</span>
            </div>
            <div class="chat-container">
            <div class="chat-header">
                <div class="user-img">
                    <asp:Image ID="userProfileImage"  runat="server" />
                    </div><div class="user-name"> <asp:Label ID="lblUserName" runat="server" /> </div>
                    <asp:HiddenField ID="hfRecieverId" runat="server" />
            </div>
            <!-- <div class="chat-box"> -->
                <!-- <div class="box sender">
                    <div class="msg ">Mark Magnum, I have question about
                        Task</div>
                    <div class="time">Today 11:52</div>
                </div>
                <div class="box receiver">
                    <div class="msg ">Yes sure, Any problem with your
                        assignment?</div>
                    <div class="time">Today 11:52</div>
                </div> -->
                <asp:UpdatePanel ID="UpdatePanel1"   runat="server" >
                    <ContentTemplate>
                        <asp:Timer ID="Timer1" runat="server" Interval="1000" ontick="Timer1_Tick"/>
                        <asp:Repeater ID="rpChat" runat="server">
                            <ItemTemplate>
                                <div class='<%# Convert.ToInt32(Eval("sender_id")) == Convert.ToInt32(Session["userId"]) ? "box sender" : "box receiver" %>'>
                                    <div class="msg"><%# Eval("message_text") %></div>
                                    <div class="time"> <%# Eval("created_at","{0:hh:mm}") %> </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="Tick" />
                    </Triggers>
                </asp:UpdatePanel>
            <!-- </div> -->
            <div class="send-msg">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                         <asp:TextBox ID="txtMsg" runat="server" CssClass="input-message" TextMode="MultiLine" placeholder="Send your message..."/>
                         <asp:Button ID="btnSend" runat="server" CssClass="btn" Text="Send" 
                                 onclick="btnSend_Click">
                        </asp:Button>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnSend" EventName="Click"/>
                    </Triggers>
                </asp:UpdatePanel>
                
            </div>
        </div>
    </div>
    <script src="js/message.js"></script>
</asp:Content>
