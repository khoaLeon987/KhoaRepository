class Admin::AdminCustomerController < ApplicationController
  
  http_basic_authenticate_with :name => 'admin' , :password => 'genoa'
  
  def index
    @customers = Customer.all
  end
  def show
    @customer = session[:customer]
  end
  
end
