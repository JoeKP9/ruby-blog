class BlogPostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :get_user_id, only: [:index, :show]
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy]
  
  def index
    @blog_posts = BlogPost.sorted
    @published_blog_posts = BlogPost.published.sorted.search(params[:search])
    @searched_blog_posts = BlogPost.sorted.search(params[:search])
    
    if user_signed_in?
      @Pagy, @blog_posts = pagy(@searched_blog_posts.where(UID: @current_user.id))
    else
      @Pagy, @blog_posts = pagy(@published_blog_posts.where(public: true))
    end
  rescue Pagy::OverflowError
    redirect_to root_path(page: 1)
  end

  def pub
    @searched_blog_posts = BlogPost.published.search(params[:search])

    @Pagy, @blog_posts = pagy(@searched_blog_posts.where(public: true)) 
  rescue Pagy::OverflowError
    redirect_to pub_blog_posts_path(page: 1)
  end

  # def like
  #   @blog_post.like(@blog_post, @current_user)

  #   render partial: "likes", locals: {blog_post: @blog_post}, content_type: "text/html", status: 500
  # end

  def show
    @blog_UID = @blog_post.UID
    @username = User.find(@blog_UID).username
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def new
    @blog_post = BlogPost.new
  end

  def edit
    if @current_user.id != @blog_post.UID
      redirect_to root_path
    end
  end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @blog_post.destroy()
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.save
      redirect_to @blog_post
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def get_user_id
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  def blog_post_params
    params.require(:blog_post).permit(:title, :content, :published_at, :UID, :public)
  end

  def set_blog_post
    @blog_post = user_signed_in? ? BlogPost.find(params[:id]) : BlogPost.published.find(params[:id])
  rescue  ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end