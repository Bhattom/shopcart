class AddQuantityToLineitemSizes < ActiveRecord::Migration[7.1]
  def change
    add_column :lineitem_sizes, :quantity, :integer
  end
end
