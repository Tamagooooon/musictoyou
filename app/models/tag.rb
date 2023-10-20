class Tag < ApplicationRecord
  has_many :post_and_tags, dependent: :destroy
  has_many :posts, through: :post_and_tags

  validates :tag_type, presence: true
end
