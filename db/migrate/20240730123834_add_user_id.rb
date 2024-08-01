class AddUserId < ActiveRecord::Migration[7.2]
  def change
    add_column :blog_posts, :UID, :integer
  end
end
