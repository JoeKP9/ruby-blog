class AddDeafaultLikesToBlogposts < ActiveRecord::Migration[7.2]
  def change
    change_column :blog_posts, :likes, :integer, :default => 0
    #Ex:- :default =>'' => 0
    #Ex:- change_column("admin_users", "email", :string, :limit =>25) :blogposts, :likes, :integer
  end
end
