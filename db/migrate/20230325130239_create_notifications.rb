class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post_comment, null: false, foreign_key: true
      t.boolean :already_read, default: false, null: false

      t.timestamps
    end
  end
end
