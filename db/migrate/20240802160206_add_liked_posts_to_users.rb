class AddLikedPostsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :liked_posts, :text
  end
end
