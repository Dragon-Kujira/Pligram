class Post < ApplicationRecord
  belongs_to :genre
  belongs_to :user
  has_many_attached :images
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :genre_id, presence: true
  validates :caption, presence: true
  validates :title, presence: true
  validates :body, presence: true
  validates :address, presence: true
  #validates :images, presence: true

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  
  def get_images
    unless images.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      images.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    images
  end
end
