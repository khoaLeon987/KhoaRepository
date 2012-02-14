class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
  
  def confirm_logged_in
    unless session[:customer]
      flash[:notice] = "Please Log in"
      redirect_to(:controller => 'web' , :action => 'login')
      return false
    else
      return true
    end    
    
  end  
  
end
