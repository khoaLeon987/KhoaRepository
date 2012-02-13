class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
       t.string  "item_desc" , :default => "" , :null => false , :limit => 100
       t.boolean  "process_stat" , :default => false  
       t.integer  "pos_index" , :default => 0
       t.references :todo_list
       t.timestamps
    end
  end
end
