class AddEmailToPayment < ActiveRecord::Migration[7.1]
  def change
    add_column :payments, :email, :string
  end
end
