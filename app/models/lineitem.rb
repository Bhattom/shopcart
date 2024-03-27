class Lineitem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  has_many :lineitem_sizes
  has_many :sizes, through: :lineitem_sizes


  def unit_price
    product.price.to_i * quantity.to_i
  end

  def total_quantity
    product.quantity.to_i - quantity.to_i
  end

end
