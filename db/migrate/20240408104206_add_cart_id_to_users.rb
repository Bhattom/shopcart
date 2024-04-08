class AddCartIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :cart, foreign_key: true
  end
end
