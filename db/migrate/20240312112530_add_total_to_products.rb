class AddTotalToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :total, :decimal, precision: 8, scale: 2, default: 0.0
  end
end
