class AddCaptionToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :caption, :string
  end
end
