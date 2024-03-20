class RemoveUserRoleFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :user_role
  end
end
