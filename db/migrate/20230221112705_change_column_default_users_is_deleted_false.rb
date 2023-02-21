class ChangeColumnDefaultUsersIsDeletedFalse < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:users, :is_deleted, false)
  end
end
