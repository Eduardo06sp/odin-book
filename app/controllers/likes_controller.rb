class LikesController < ApplicationController
  def create
    @post = Post.find_by(id: params[:post])
    user = User.find_by(id: params[:user])

    like = Like.new(post: @post, user:)

    if like.save
      flash[:notice] = 'Liked the post!'
    else
      flash[:alert] = 'Unable to like post.'
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  def destroy
    like = Like.find(params[:id])

    if like.destroy
      flash[:notice] = 'Unliked post.'
    else
      flash[:alert] = 'Unable to dislike post.'
    end

    redirect_to root_path
  end
end
