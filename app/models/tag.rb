class Tag < ApplicationRecord
  #Tagsテーブルから中間テーブルに対する関連付け
  has_many :post_tags, dependent: :destroy
  #Tagsテーブルから中間テーブルを介してPostテーブルへの関連付け
  has_many :posts, through: :post_tags
end
