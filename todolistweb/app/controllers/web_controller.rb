class WebController < ApplicationController
    before_filter :confirm_logged_in , :except => [:login , :logout , :index]
  def index
      session[:customer] = nil
      @todo_list = TodoList.random
  end
  
  def login
        if request.get?

        else
             check = Customer.check_login(params[:uname],params[:pass])
              if check
                session[:customer] = check

                redirect_to(customer_todo_lists_url(check))
              else
                flash[:notice] = "Login failed please check your username and password"
                render('login')
              end
        end

  end   
  def confirm_logged_in
           unless session[:customer]
             flash[:notice] = "Please Log in"
             redirect_to(:controller => 'web' , :action => 'login')
             return false
           else
             return true
           end    

  end  
  def success
  end  
  def logout

      session[:customer] = nil
      redirect_to(:controller => 'web',:action =>'index')

  end

end
