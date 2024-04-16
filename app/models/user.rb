class User < ApplicationRecord
  has_many :orders
  has_many :addresses
  has_many :carts, dependent: :destroy
  rolify
  paginates_per 10
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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
end

