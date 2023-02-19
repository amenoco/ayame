class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.string :title,          null:false, default: ""
      t.string :text,           null:false, default: ""
      t.integer :user_id,       null:false, default: ""
      t.integer :category_id,   null:false, default: ""
     
      
      t.timestamps
    end
  end
end
