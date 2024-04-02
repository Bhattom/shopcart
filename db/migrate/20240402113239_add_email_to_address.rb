class AddEmailToAddress < ActiveRecord::Migration[7.1]
  def change
    add_column :addresses, :email, :string
  end
end
