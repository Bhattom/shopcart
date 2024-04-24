class RemoveConfirmedFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :confirmed, :string
    remove_column :users, :booloan, :string
  end
end
