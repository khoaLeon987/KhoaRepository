class Customer < ActiveRecord::Base
  
   #has_many :todo_lists

   validates :login_name , :uniqueness => true, :presence => true
   validates :password , :presence => true , :confirmation => true
   validates :email ,:uniqueness => true , :presence => true, :format => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ , :confirmation => true

   attr_accessor :is_changing_password , :old_email, :is_changing_email , :new_pass, :old_pass, :new_pass_confirm

   #validate :validate_during_changing_password , :validate_during_changing_email
  
  
end
