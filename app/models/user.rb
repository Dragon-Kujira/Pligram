class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates :name, presence: true       

 has_many :posts, dependent: :destroy
 has_many :comments, dependent: :destroy
 has_many :favorites, dependent: :destroy
 has_many :favorite_posts, through: :favorites, source: :post
 has_one_attached :image

 def active_for_authentication?
  super && (is_active == true)
 end

 def get_image
  unless image.attached?
    file_path = Rails.root.join('app/assets/images/no_user_image.jpg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  image
end
end
