class AddPaymentToCarts < ActiveRecord::Migration[7.1]
  def change
    add_column :carts, :payment, :boolean
  end
end
