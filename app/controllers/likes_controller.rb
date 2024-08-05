class LikesController < ApplicationController
  before_action :find_post
  before_action :find_like, only: [:destroy]

  def create
    if already_liked?
      # flash[:notice] = "You can't like more than once"
    else
      @blog_post.likes.create(user_id: current_user.id)
      
    end
    redirect_to blog_post_path
  end

  def destroy
    if !(already_liked?)
      # flash[:notice] = "Cannot unlike"
    else
      @like.destroy()
    end
    redirect_to blog_post_path
  end

  def already_liked?
    Like.where(user_id: current_user.id, blog_post_id: params[:id]).exists?
  end

  private

  def find_like
    @like = Like.where(user_id: current_user.id, blog_post_id: params[:id])[0]
  end

  def find_post
    @blog_post = BlogPost.find(params[:id])
  end
end
