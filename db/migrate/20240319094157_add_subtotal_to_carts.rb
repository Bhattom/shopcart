class AddSubtotalToCarts < ActiveRecord::Migration[7.1]
  def change
    add_column :carts, :subtotal, :integer, default: 0
  end
end
