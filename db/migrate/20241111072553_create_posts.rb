class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.string :images
      t.integer :user_id, null: false
      t.integer :genre_id, null: false
      t.string :address, null: false
      t.timestamps
    end
  end
end
