class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         validates :email,           format: { with: /@/}
         validates :password,        length: { minimum: 6 }, confirmation: true,  format: { with: /\A[a-zA-Z0-9]+\z/ }

         validates :name, presence: true
         validates :profile, presence: true
end
