class AddTotalToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :total, :integer
  end
end
