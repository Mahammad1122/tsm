$(document).ready(function () {
    $("#menuUser ul li a").each(function (index, element) {
        if($(element).text() == " Overview"){
            $(element).css("color","#151222");
            $(element).parent().css("background-color","#f5f5f7");
            $(element).find(".icon path").css("fill","#151222");
        }
    });
    $(".status").each(function (index, element) {
        console.log($(element).text())
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

});