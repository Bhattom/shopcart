class Order < ApplicationRecord
    belongs_to :user
    belongs_to :cart

  validates :user_id, presence: true
  validates :cart_id, presence: true
end
