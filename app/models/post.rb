class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  attachment :post_image

  validates :text, presence: true
  validates :post_image, presence: true


end
