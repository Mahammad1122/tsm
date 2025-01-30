$(document).ready(function () {
    $("#ContentPlaceHolder1_UpdatePanel1").addClass("chat-box");
    $(".chat-box").scrollTop($(".chat-box")[0].scrollHeight);
    if($(".chat-header .user-name").text().trim() == "")
    {
        $(".chat-container").hide();
        $(".blank-container").show();
    }
    else{
        $(".chat-container").show();
        $(".blank-container").hide();
    }
    $("#menuUser ul li a").each(function (index, element) {
        if($(element).text() == " Message"){
            $(element).css("color","#151222");
            $(element).parent().css("background-color","#f5f5f7");
            $(element).find(".icon path").css("fill","#151222");
        }
    });
});