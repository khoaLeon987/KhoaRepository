class Customer < ActiveRecord::Base
  
   has_many :todo_lists

   validates :login_name , :uniqueness => true, :presence => true
   validates :password , :presence => true , :confirmation => true
   validates :email ,:uniqueness => true , :presence => true, :format => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ , :confirmation => true

   attr_accessor :is_changing_password , :old_email, :is_changing_email , :new_pass, :old_pass, :new_pass_confirm

   validate :validate_during_changing_password , :validate_during_changing_email
   
   before_save do |customer|
     if customer.is_changing_password
       customer.password = customer.new_pass      
     end

   end

   def validate_during_changing_password
     if is_changing_password == true
       if Customer.check_login(self.login_name, self.old_pass) == false
         errors.add(:old_pass, 'Password does not match')
       end
       if self.new_pass != self.new_pass_confirm
         errors.add(:new_pass_confirm, 'Password confirmation does not match')
       end
       if self.new_pass == self.old_pass
         errors.add(:new_pass, 'New password cannot be the same as old passwork')
       end
     end
   end

   def validate_during_changing_email
      if is_changing_email == true
           if self.old_email == self.email
             errors.add(:email , 'New email cannot be the same as old one' )
           end
       end           
   end    
   
   def self.check_login(username="",pass="")
        user = Customer.find_by_login_name(username)
      if user && user.password == pass
           return user
      else
           return false
      end     
    end  
  
end
