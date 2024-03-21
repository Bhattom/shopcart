class AddProductIdToSimilarProducts < ActiveRecord::Migration[7.1]
  def change
    add_reference :similar_products, :product, foreign_key: true
  end
end
