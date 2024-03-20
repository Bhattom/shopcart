class AddUnitPriceToLineitems < ActiveRecord::Migration[7.1]
  def change
    add_column :lineitems, :unit_price, :integer
  end
end
