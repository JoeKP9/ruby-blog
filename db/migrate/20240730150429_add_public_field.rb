class AddPublicField < ActiveRecord::Migration[7.2]
  def change
    add_column :blog_posts, :public, :boolean, :default => false
    #Ex:- :default =>''
  end
end
