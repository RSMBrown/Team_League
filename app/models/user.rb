class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, 
         :rememberable, :validatable

  enum roles: { manager: 0, coordinator: 1 }
end
