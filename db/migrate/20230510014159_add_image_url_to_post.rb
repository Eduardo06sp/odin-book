class AddImageUrlToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :image_url, :text
  end
end
