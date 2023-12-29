class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)

    if @comment.save
      flash[:notice] = 'Added comment.'
    else
      flash[:alert] = 'Unable to add comment.'
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back_or_to root_path }
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back_or_to root_path, status: :see_other }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
