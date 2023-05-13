class PostsController < ApplicationController
  def index
    @posts = Post.user_and_friends(current_user).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

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
end
