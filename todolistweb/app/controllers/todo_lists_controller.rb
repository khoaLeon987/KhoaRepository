class TodoListsController < ApplicationController
  
      before_filter :confirm_logged_in 

      def create
        customer = Customer.find_by_id(session[:customer].id)
        @todo_list = TodoList.new(params[:todo_list])
          if customer.todo_lists << @todo_list
             redirect_to(todo_list_items_url(@todo_list))
          else
              render('new')
          end


      end   
      
      def sort_item
          mapArr = params[:map]

          i=1 
          mapArr.each do |id|
            item =  Item.find_by_id(id)      
            item.update_attributes(:pos_index => i )
            i += 1
          end  

          # redirect_to(:controller =>'todo_list', :action => 'show' ,:cid => params[:cid] )
          render :text => "successful"
      end  

      def new
      @new_list = TodoList.new()

    end

      def index
      customer = Customer.find_by_id(session[:customer].id)
      @lists = customer.todo_lists

      end  

    def edit
        @cus = Customer.find_by_id(session[:customer].id)
        @todo_list = @cus.todo_lists.find_by_id(params[:id])
        if @todo_list
           @items = @todo_list.items
        else
          render :text => "you are not authorized to view this list"
        end
    end  
    def update
      customer = Customer.find_by_id(session[:customer].id)
      @todo_list = customer.todo_lists.find_by_id(params[:id])
      if( @todo_list.update_attributes(params[:todo_list])) 
          redirect_to (todo_list_items_url(@todo_list))
      else
          render :action => 'edit'
      end
    end  
    def delete
         customer = Customer.find_by_id(session[:customer].id)
         @todo_list = customer.todo_lists.find_by_id(params[:id])
         items_to_be_destroy = @todo_list.items
         if(TodoList.delete(@todo_list))
             Item.delete(items_to_be_destroy)  
             flash[:notice] = "Successfull remove lists !"
             redirect_to(customer_todo_lists_url(customer)) 
         else 

         end
    end  
     
end

