class ResetLikesToBlogPosts < ActiveRecord::Migration[7.2]
  def change
    
    BlogPost.update_all("likes=0")

  end
end
