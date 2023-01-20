class RemoveDateCreatedFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :date_created, :datetime
  end
end
