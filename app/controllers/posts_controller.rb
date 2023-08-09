class PostsController < ApplicationController
  require 'open-uri'

  include ActiveStorage::SetCurrent

  def index
    @post = Post.new
    @posts = Post
      .includes(
        :liking_users,
        comments: :user,
        user: {avatar_attachment: {blob: {variant_records: {image_attachment: :blob}}}}
      )
      .with_attached_image
      .user_and_friends(current_user)
      .order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    begin
      if params[:post][:image_url].present?
        attach_image_from_url
      end
    rescue SocketError
      flash[:alert] = 'Unable to access image URL provided.'
      redirect_back_or_to root_path
      return
    rescue Errno::ECONNREFUSED
      flash[:alert] = 'Unable to connect to URL provided. Please double check the URL.'
      redirect_back_or_to root_path
      return
    end

    if @post.save
      flash[:notice] = 'Successfully created new post.'
    else
      flash[:alert] = 'Unable to create post.'
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back_or_to root_path }
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back_or_to root_path, status: :see_other }
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
