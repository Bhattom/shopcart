class User < ApplicationRecord
  devise :two_factor_authenticatable
  has_many :orders
  has_many :addresses
  has_many :carts, dependent: :destroy
  rolify
  paginates_per 10
  before_create :generate_verification_code
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable,
         :recoverable, :rememberable, :validatable, :two_factor_authenticatable

         role = %w{admin guest}


         def admin?
           role == 'admin'
         end
         def guest?
           role == 'guest'
         end

         def run
          User.find_each do |user|
            UserMailer.with(user: user).deliver_later
          end
        end

        def generate_verification_code
          verification_code = '%06d' % rand(1000000)
          update_attribute(:verification_code, verification_code)
          verification_code
        end
end

