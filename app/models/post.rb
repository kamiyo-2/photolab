class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  attachment :post_image

  validates :text, presence: true
  validates :post_image, presence: true
end
