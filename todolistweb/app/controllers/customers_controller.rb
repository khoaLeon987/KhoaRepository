class CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end
  def new
    @customer = Customer.new
  end
  def create
    @customer = Customer.new(params[:customer])
    if @customer.save
       redirect_to(:action => 'index')
    else
       render('new')
    end     
  end    
  def show
     @customer = session[:customer]
  end  
  def change_password
     @customer = Customer.find_by_login_name(session[:customer].login_name)
     if request.get?
       # request is a get, display the form
     else # request is a post or put request, then do the job      
       @customer.is_changing_password = true
       if @customer.update_attributes(params[:customer])
         flash[:notice] = "update password finish"
         redirect_to :action => "change_password"
       else
         render :action => :change_password
       end
     end
   end
   def change_email
     @customer = Customer.find_by_login_name(session[:customer].login_name)
     @customer.old_email = @customer.email
     if request.get?
     else
       @customer.is_changing_email = true
       if @customer.update_attributes(params[:customer])
          flash[:notice] = "update Email finish"
          redirect_to :action => "change_email"
       else
          render :action => 'change_email'
       end
     end       
   end  
  
end
