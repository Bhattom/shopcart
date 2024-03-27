class Size < ApplicationRecord
  belongs_to :product
  has_many :lineitem_sizes
  has_many :lineitems, through: :lineitem_sizes
end
