class Lineitem < ApplicationRecord
  belongs_to :product
  belongs_to :cart


  def unit_price
    product.price.to_i * quantity.to_i
  end

  def total_quantity
    product.quantity.to_i - quantity.to_i
  end

end
