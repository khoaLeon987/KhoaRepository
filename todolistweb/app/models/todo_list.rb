class TodoList < ActiveRecord::Base
  has_many :items
  belongs_to :customer
  
   validates :list_name, :presence => true
   accepts_nested_attributes_for :items, :allow_destroy => true , :reject_if => lambda{ |a| a[:item_desc].blank? }
   
   def self.random
      if (c = count)!= 0
        find(:first , :offset => rand(c) )
      end  
   end
  
end
