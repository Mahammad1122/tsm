
function showConfirm(){
    if(!confirm("Are you sure you want to Delete Task ?")){
        return false;
    }
}
$(document).ready(function () {
    $("#menuUser ul li a").each(function (index, element) {
        if($(element).text() == " Task"){
            $(element).css("color","#151222");
            $(element).parent().css("background-color","#f5f5f7");
            $(element).find(".icon-path").css("stroke","#151222");
        }
    });
    $(".project-loader").show();
    //add color to  navigation-btn 
    switch($(".task-title").text())
    {
        case "In Progress Tasks":
            $(".btn-inprogress").css("color", "#e76e0b");
            break;
        case "Pending Tasks":
            $(".btn-pending").css("color", "#e72020");
            break;
        case "Completed Tasks":
            $(".btn-completed").css("color", "#20b334");
            break;
        case "Assigned Tasks":
            $(".btn-assigned").css("color", "#eb6e0b");
            break;
        case "Normal Tasks":
            $(".btn-normal").css("background-color", "#5577ff66");
            break;
        case "Medium Tasks":
            $(".btn-medium").css("background-color", "#e76e0b66");
            break;
        case "High Tasks":
            $(".btn-high").css("background-color", "#e7202066");
            break;    
    }
});
$(window).on('load', function () {
    $(".project-loader").fadeOut(1000);
});
$(".checkbox").click(function(e) {
    var id = $(this).find("label").text();
    // if($(".checkbox input:checked").length > 1){
    //     alert("select one at a time");
    //     $(this).find("input").prop("checked",false);
    // }
    if(e.target.checked) {
        $("#"+id).css("display", "grid");
    }
    else {
        $("#"+id).css("display", "none");
    }
});
$(".status").each(function (index,element) {
   if($(element).text() =="In Progress"){
        $(element).css("color", "#e76e0b");
   }
   else if($(element).text() =="Pending"){
        $(element).css("color", "#e72020");
    }
    else{
        $(element).css("color", "#20b334");
    }
});

$(".priority").each(function (index,element) {
    if($(element).text() =="Medium"){
         $(element).css("color", "#e76e0b");
    }
    else if($(element).text() =="High"){
         $(element).css("color", "#e72020");
     }
     else{
         $(element).css("color", "#5577FF");
     }
 });
$(".task-validation").change(function () { 
    if($(".task-validation").css("visiblity") != "visible"){
        $(".task-validation").css("display","none");
    } 
    else{
        $(".task-validation").css("display","block");
    }
});