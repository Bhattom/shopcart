class DropLineItem < ActiveRecord::Migration[7.1]
  def change
    drop_table :line_items
  end
end
