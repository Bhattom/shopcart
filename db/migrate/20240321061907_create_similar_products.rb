class CreateSimilarProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :similar_products do |t|
      t.string :name
      t.text :desc
      t.integer :price
      t.string :size
      t.integer :quantity

      t.timestamps
    end
  end
end
