class Order < ApplicationRecord
    belongs_to :user
    belongs_to :cart
    has_one :payment

  validates :user_id, presence: true
  validates :cart_id, presence: true

  enum track: { OrderPlaced: 0, Shipped: 1, Delivered: 2, Received: 3 }
  
end

