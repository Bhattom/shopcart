class CreateSizes < ActiveRecord::Migration[7.1]
  def change
    create_table :sizes do |t|
      t.string :name
      t.string :abbreviation
      t.integer :stock_quantity
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
