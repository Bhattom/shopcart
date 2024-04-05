class AddContactToPayment < ActiveRecord::Migration[7.1]
  def change
    add_column :payments, :contact, :integer
  end
end
