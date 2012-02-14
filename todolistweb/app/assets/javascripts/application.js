// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
function addItemAjax(url) {
	$("#add_item_button").click(function(){
		// $.post("/todo_list/item", {
		// 	name: $("#item_val").val(),
		// 	id: $("#c_list_id").val()
		// }, function(result) {
		// 	alert(result.id);
		// }, "json");
		$.ajax({
			type:"POST",
			url: url,
			data: {
					name: $("#item_val").val(),
					
			},
			success: function(result){
				if(result == "fail")
				{
					alert("item name must not blank !!!");
				}else{
						var item = result;

						var l0="<li item_id='";
						var l1= item.id + "' item_pos='" +item.pos_index +  "'><input type='checkbox' value='1' class=check_item >";
						var l2= item.item_desc+"</li>";
						$("#todolist_items").append(l0+l1+l2);
						$("#item_val").val("");
				}				
			
			},
			beforeSend: function(){

			},
			error: function(xhr){

			}							
		});
		return false;
	});		
}

function setItemProcess(path_check,path_uncheck){
	
	
		// $.post("/todo_list/item", {
		// 	name: $("#item_val").val(),
		// 	id: $("#c_list_id").val()
		// }, function(result) {
		// 	alert(result.id);
		// }, "json");
	    	$(".item_list").delegate(".check_item","change",function() {
 				
				if($(this).attr("checked") == "checked") { //checked
					   var that = this;
                    	$.ajax({
							type:"POST",
							url: path_check,
								data: {
								    
									id: $(this).parent().attr("item_id")
							},
							success: function(result){				
							    $(that).parent().fadeTo("slow",0,function(){
								
								 		$(that).parent().remove();
								        var item = result;

										var l0="<li item_id='";
										var l1= item.id + "' item_pos='" +item.pos_index  + "'><input type='checkbox' value='1' checked=true class='check_item' >";
										var l2= item.item_desc+"</li>";
										$("#todolist_done").append(l0+l1+l2);
										
										$("#todolist_items").children().each(function(index){
											 $(this).attr("item_pos",index+1);

										} );
								
							});  
							},
							beforeSend: function(){

							},
							error: function(xhr){

							}							
						});  
				}//end if
				else { //uncheck
					
					 var that = this;
                    	$.ajax({
							type:"POST",
							url: path_uncheck,
								data: {
								
									id: $(this).parent().attr("item_id"),
									
							},
							success: function(result){				
							    $(that).parent().fadeTo("slow",0,function(){
								 		$(that).parent().remove();
								        var item = result;
										var l0="<li item_id='";
										var l1= item.id + "' item_pos='" +item.pos_index + "'><input type='checkbox' value='0' class='check_item' >";
										var l2= item.item_desc+"</li>";
										$("#todolist_items").append(l0+l1+l2);
									});  
							},
							beforeSend: function(){

							},
							error: function(xhr){

							}							
						});
				}
			});
		return false;
	
}
	
function sortItem( arrmap ){
	
	$.ajax({
		type:"GET",
		url:"/todo_lists/sort_item",
		data :{
			
			map: arrmap
			
		},
		success: function(result){
		
		},
		
		beforeSend: function(){},
		
		error:function(){}

	});
}	
