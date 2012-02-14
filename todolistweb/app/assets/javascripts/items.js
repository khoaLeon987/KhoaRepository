
function makeItem(){
	$(".create-item-box").css("visibility" , "visible");
	$("#linkOpen").css("visibility" , "hidden");
	
}

function closeBox(){
	$(".create-item-box").css("visibility" , "hidden");
	$("#linkOpen").css("visibility" , "visible");
}

function removeItem(){
	$(".box").delegate(".delete-button","click",function(){
		 $(this).parent().find(".remove-check").attr("checked","checked")
		 $(this).parent().parent().css("display","none");
	})
	
}