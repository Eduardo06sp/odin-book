class PostsController < ApplicationController
  require 'open-uri'

  def index
    @posts = Post.user_and_friends(current_user).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if params[:post][:image_url].present?
      attach_image_from_url
    end

    if @post.save
      flash[:notice] = 'Successfully created new post.'
      redirect_to root_path
    else
      flash[:alert] = 'Unable to create post.'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :image, :image_url)
  end

  def attach_image_from_url
    @post.image.attach(io: URI.parse(params[:post][:image_url]).open, filename: 'post-image')
  end
end
