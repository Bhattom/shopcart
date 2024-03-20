class User < ApplicationRecord
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
end
