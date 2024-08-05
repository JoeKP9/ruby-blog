class BlogPost < ApplicationRecord

  has_many :likes, dependent: :destroy
  has_rich_text :content

  validates :title, presence: true, length: {maximum: 35}
  validates :content, presence: true

  scope :sorted, -> {order(arel_table[:published_at].desc.nulls_first).order(updated_at: :desc)}
  scope :search, ->(text) {sorted.where("title like ?", "%"+text.to_s+"%")
  .or(sorted.where("UID like ?", "%"+text.to_s+"%"))
  .or(sorted.where("UID like ?", User.where("username like ?", "%"+text.to_s+"%").ids[0]))}
  # scope :sorted, -> {order(published_at: :desc, updated_at: :asc)}
  scope :draft, -> {where(published_at: nil)}
  scope :published, -> {where("published_at <= ?", Time.current)}
  scope :scheduled, -> {where("published_at > ?", Time.current)}

  def draft?
    published_at.nil?
  end
  
  def scheduled?
    published_at? && published_at > Time.current
  end

  def private?
    public? == false
  end

  def edited?
    published_at? && created_at < updated_at - 1.minute
  end

  # def liked_by?(blog_post, currentuser)
  #   if currentuser.liked_posts != nil
  #     users_liked_posts = currentuser.liked_posts.split(',')
  #     blog_post_id = blog_post.id.to_s
  #     users_liked_posts.include?(blog_post_id)
  #   else
  #     return false
  #   end
  # end

  # def like(blog_post, currentuser)
  #   if !users_liked_posts = currentuser.liked_posts.split(',')
  #     users_liked_posts = ""
  #   end
  #   liked_posts = currentuser.liked_posts.to_s
  #   blog_post_id = blog_post.id.to_s
  #   if !users_liked_posts.include?(blog_post_id)
  #     likes = blog_post.likes
  #     blog_post.likes += 1
  #     if blog_post.save(touch: false)
  #       User.where(id: currentuser.id).update(liked_posts: liked_posts+blog_post_id+",")
  #     end
  #   else
  #     blog_post.unlike(blog_post, currentuser, blog_post_id, users_liked_posts)
  #   end
  # end

  # def unlike(blog_post, currentuser, blog_post_id, users_liked_posts)
  #   if users_liked_posts.delete(blog_post_id)
  #     if users_liked_posts.length === 1
  #       users_updated_liked_posts = users_liked_posts.join(",").to_s + ","
  #     else
  #       users_updated_liked_posts = users_liked_posts.join(",")
  #     end
  #     likes = blog_post.likes
  #     if blog_post.update(likes: likes -= 1)
  #       User.where(id: currentuser.id).update(liked_posts: users_updated_liked_posts)
  #     end
  #   end
  # end
end

# BlogPosts.all
# BlogPosts.draft
# BlogPosts.published
# BlogPosts.scheduled