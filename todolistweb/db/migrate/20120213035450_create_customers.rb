class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
        t.string "login_name" , :limit => 50
        t.string "full_name"  , :limit => 50
        t.string "email"     , :default => "" , :null => false , :limit => 150
        t.string "password"  , :default =>"" , :null => false , :limit => 50
        t.timestamps
      t.timestamps
    end
  end
end
