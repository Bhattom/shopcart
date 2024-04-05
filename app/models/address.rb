class Address < ApplicationRecord
    belongs_to :user
   
    validates :pincode, numericality: { only_integer: true}, length: { is: 6 }
    validates :name, presence: true
    validates :phone_no, numericality: { only_integer: true}, length: { is: 10 }
    validates :address, presence: true
end
