class Post < ApplicationRecord
  belongs_to :user
  attachment :post_image

  validates :text, presence: true
  validates :post_image, presence: true
end
