class CreateTodoLists < ActiveRecord::Migration
  def change
    create_table :todo_lists do |t|
       t.string  "list_name" , :default => "" , :null => false , :limit => 100
       t.string  "list_desc"  
       t.references :customer
       t.boolean "share_value" , :default => false 
       t.timestamps
       
    end
  end
end
