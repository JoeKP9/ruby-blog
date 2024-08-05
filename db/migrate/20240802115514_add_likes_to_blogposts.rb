class AddLikesToBlogposts < ActiveRecord::Migration[7.2]
  def change
    add_column :blog_posts, :likes, :integer
  end
end
