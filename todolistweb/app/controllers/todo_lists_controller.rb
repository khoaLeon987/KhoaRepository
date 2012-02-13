class TodoListsController < ApplicationController
  
  class TodoListController < ApplicationController

    before_filter :confirm_logged_in 

    def create
      @cus = Customer.find_by_login_name(session[:uname])
      @todo_list = TodoList.new(params[:todo_list])



         if @cus.todo_lists << @todo_list
              redirect_to(:controller =>'todo_list' , :action => 'show'  , :cid => @todo_list.id)
            else
              render('new')
            end


    end   

    def item
       list = TodoList.find_by_id(params[:cid])

       pos = list.list_items.where(:process_status => false).count()
       pos += 1
       @new_item = ListItem.new(:itemDesc => params[:name], :pos_index => pos )

       if params[:name].blank? == true

          render :text => "fail"

       else   
         if list.list_items << @new_item
         # return @new_item.itemDesc       
         # render :text => @new_item.itemDesc
         # render :layout => false

          render :json => @new_item
        else
        end   
       end           

    end    
    def item_check
       list_sort = TodoList.find_by_id(params[:cid]).list_items.where(:process_status => false ).order("pos_index ASC")
       count = list_sort.size()
       @item = ListItem.find(params[:id])

       index = @item.pos_index 
       pos   = index + 1 
       while (pos <= count )

           list_sort[pos-1].update_attributes(:pos_index => index )
           pos += 1
           index += 1  
       end 

        if @item.update_attributes(:process_status => true , :pos_index => 0)
          render :json => @item
        end

    end

    def item_unchecked
       @list = TodoList.find_by_id(params[:listId])

       pos = @list.list_items.where(:process_status => false).count()
       @item = ListItem.find(params[:id])

       pos += 1  

        if @item.update_attributes(:process_status => false , :pos_index => pos
          )
          render :json => @item
        end

    end      


    def sort_item
       mapArr = params[:map]

       i=1 
       mapArr.each do |id|
         item =  ListItem.find_by_id(id)      
         item.update_attributes(:pos_index => i )
         i += 1
        end  

        # redirect_to(:controller =>'todo_list', :action => 'show' ,:cid => params[:cid] )
        render :text => "successful"
    end  


    def show    
      @cus = Customer.find_by_login_name(session[:uname])
      @c_list = @cus.todo_lists.find_by_id(params[:cid])
      if @c_list
        @details = @c_list.list_items.where(:process_status => false).order("pos_index ASC")
        @details_done = @c_list.list_items.where(:process_status => true)
      else
        render :text => "you are not authorized to view this list"
      end
    end  


    def new
      @new_list = TodoList.new()

    end

    def list
      cus = Customer.find_by_login_name(session[:uname])
      @list = cus.to_do_lists

    end  
    def edit
        @cus = Customer.find_by_login_name(session[:uname])
        @c_list = @cus.todo_lists.find_by_id(params[:cid])
        if @c_list
          @details = @c_list.list_items
        else
          render :text => "you are not authorized to view this list"
        end
    end  
    def update
      @cus = Customer.find_by_login_name(session[:uname])
      @c_list = @cus.todo_lists.find_by_id(params[:cid])
      if(@c_list.update_attributes(params[:todo_list])) 
          redirect_to :action => "show", :cid => @c_list.id
      else
        puts @c_list.errors.inspect
        render :action => :edit
      end
    end  
    def delete
         @cus = Customer.find_by_login_name(session[:uname])
         @c_list = @cus.todo_lists.find_by_id(params[:cid])

         if(TodoList.delete(@c_list))
             flash[:notice] = "Successfull remove lists !"
             redirect_to(:controller => 'customer', :action => 'manage' ) 
         else 

         end
    end  
  end

