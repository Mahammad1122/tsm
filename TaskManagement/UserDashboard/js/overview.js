$(document).ready(function () {
    //hide notification panel
    $(".notification").hide();
    //select overview menu 
    $("#menuUser ul li a").each(function (index, element) {
        if($(element).text() == " Overview"){
            $(element).css("color","#151222");
            $(element).parent().css("background-color","#f5f5f7");
            $(element).find(".icon path").css("fill","#151222");
        }
    });
    //add style to task status    
    $(".status").each(function (index, element) {
        if($(element).text().trim() == "Pending"){
            $(element).addClass("pending");
        }
        if($(element).text().trim() == "In Progress"){
            $(element).addClass("in-progress");
        }
        if($(element).text().trim() == "Completed"){
            $(element).addClass("completed");
        }
    });
    //show hide when notification icon clicked
    $(".notification-icon").click(function () { 
        if($(".notification").is(":visible")){
            $(".notification-icon path").css("fill", "#6b6e94");
            $(".notification").fadeOut();
        }else{
            $(".notification-icon path").css("fill", "#475467");    
            $(".notification").fadeIn();
        }
    });
    
    $(document).click(()=> {
        if($(".notification-icon").length > 0)
        {
            let notificationBtnClicked = $.contains($('.notification-icon')[0], event.target);
            let notificationClicked = $.contains($('.notification')[0], event.target);
            if(!notificationClicked && !notificationBtnClicked)
            {
                $(".notification").fadeOut();
                $(".notification-icon path").css("fill", "#6b6e94");
            }
        }
    });
    // if($(".task .row").length == 0)
    // {
    //    $(".today-task-container").hide(); 
    // }
    // else{
    //    $(".today-task-container").show(); 
    // }
});