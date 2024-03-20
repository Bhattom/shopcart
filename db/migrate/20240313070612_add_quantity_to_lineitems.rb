class AddQuantityToLineitems < ActiveRecord::Migration[7.1]
  def change
    add_column :lineitems, :quantity, :integer
  end
end
