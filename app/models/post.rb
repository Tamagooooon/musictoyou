class Post < ApplicationRecord
  has_one_attached :image
  has_one_attached :audio
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :post_and_tags, dependent: :destroy
  has_many :tags, through: :post_and_tags

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  def favorited_by?(admin)
    favorites.exists?(@user_id)
  end

  def find_bookmark(user)
    bookmarks.find_by(user_id: user.id)
  end

  def find_bookmark(admin)
    bookmarks.find_by(@user_id)
  end

  def self.search(keyword)
    where("title LIKE ? or body LIKE ?", "%#{keyword}%", "%#{keyword}%" )
  end

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
end
