class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)

    if comment.save
      flash[:notice] = 'Added comment.'
    else
      flash[:alert] = 'Unable to add comment.'
    end

    redirect_back_or_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
