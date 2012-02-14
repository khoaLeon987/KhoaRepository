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
end
