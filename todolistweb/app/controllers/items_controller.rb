class ItemsController < ApplicationController
  
  def item_check
     list_sort = TodoList.find_by_id(params[:todo_list_id]).items.where(:process_stat => false ).order("pos_index ASC")
     count = list_sort.size()
     @item = Item.find(params[:id])

     index = @item.pos_index 
     pos   = index + 1 
     while (pos <= count )

         list_sort[pos-1].update_attributes(:pos_index => index )
         pos += 1
         index += 1  
     end 

      if @item.update_attributes(:process_stat => true , :pos_index => 0)
        render :json => @item
      end

  end
  
  def item_unchecked
       @list = TodoList.find_by_id(params[:todo_list_id])

       pos = @list.items.where(:process_stat => false).count()
       @item = Item.find(params[:id])

       pos += 1  

      if @item.update_attributes(:process_stat => false , :pos_index => pos
          )
          render :json => @item
      end
  end
   
  def create
      list = TodoList.find_by_id(params[:todo_list_id])

      pos = list.items.where(:process_stat => false).count()
      pos += 1
      @new_item = Item.new(:item_desc => params[:name], :pos_index => pos )

      if params[:name].blank? == true
         render :text => "fail"
      else   
          if list.items << @new_item
            # return @new_item.itemDesc       
            # render :text => @new_item.itemDesc
            # render :layout => false

          render :json => @new_item
          else
          end   
      end           

  end

  def index
    cus = session[:customer]
    @todo_list = cus.todo_lists.find_by_id(params[:todo_list_id])
    if @todo_list
      @details = @todo_list.items.where(:process_stat => false).order("pos_index ASC")
      @details_done = @todo_list.items.where(:process_stat => true)
    else
      render :text => "you are not allowed to view others list"
    end
  end
 
end
