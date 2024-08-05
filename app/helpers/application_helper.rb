module ApplicationHelper
  include Pagy::Frontend

  def blog_post_colour(blog, is_public_page, current_user)
      return "bg-red-100" if blog.draft?
      return "bg-blue-100" if blog.scheduled?
      return "bg-gray-300" if blog.private?
      return "bg-green-100" if (blog.UID == current_user&.id) && is_public_page
      "bg-gray-100"
  end

  def like_button_text(blog_post, current_user)
    if blog_post.liked_by?(blog_post, current_user)
      return "Unlike"
    end
    return "Like"
    # if liked = current_user.liked_posts.split(",").include?(blog_post.id)
    #   return("Unlike")
    # else
    #   return("Like")
    # end
  end

end
