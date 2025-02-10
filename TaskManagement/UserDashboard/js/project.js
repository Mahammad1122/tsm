
function showConfirm(){
    if(!confirm("Are you sure you want to Delete Task ?")){
        return false;
    }
}
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
$(document).ready(function () {
    $("#menuUser ul li a").each(function (index, element) {
        if($(element).text() == " Project"){
            $(element).css("color","#151222");
            $(element).parent().css("background-color","#f5f5f7");
            $(element).find(".icon-path").css("stroke","#151222");
        }
    });
    //add color to  navigation-btn 
    console.log($(".task-title").text())
    switch($(".task-title").text().trim())
    {
        case "In Progress Projects":
            $(".btn-inprogress").css("color", "#e76e0b");
            break;
        case "Pending Projects":
            $(".btn-pending").css("color", "#e72020");
            break;
        case "Completed Projects":
            $(".btn-completed").css("color", "#20b334");
            break;   
    }
});