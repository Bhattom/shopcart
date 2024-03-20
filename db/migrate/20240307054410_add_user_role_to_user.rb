class AddUserRoleToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :user_role, :integer
  end
end
