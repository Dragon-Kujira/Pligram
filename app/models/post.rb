class Post < ApplicationRecord
  belongs_to :genre
  belongs_to :user
  has_many_attached :images, dependent: :destroy
  
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  #Postsテーブルから中間テーブルに対する関連付け
  has_many :post_tags, dependent: :destroy
  #Postsテーブルから中間テーブルを介してTagsテーブルへの関連付け
  has_many :tags, through: :post_tags, dependent: :destroy
  
  validates :caption, presence: true
  validates :tags, presence: true
  validates :body, presence: true
  validates :address, presence: true
  #validates :images, presence: true

  def favorited_by?(user)
    user.present? && favorites.exists?(user_id: user.id)
  end
  
  # タグの名前を簡単に扱うためのメソッドを追加
  def tag_names
    tags.pluck(:name).join(', ')
  end

  def tag_names=(names)
    self.tags = names.split(',').map do |name|
      Tag.find_or_create_by(name: name.strip)
    end
  end

  def get_images
    unless images.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      images.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    images
  end

  def google_maps_url
    base_url = "https://www.google.com/maps/search/?api=1"
    "#{base_url}&query=#{CGI.escape(address)}"
  end


  
end
