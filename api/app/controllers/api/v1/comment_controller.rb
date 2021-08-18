class Api::V1::CommentController < ApplicationController

  def create
    comment = comment.new(comment_params)
    byebug
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :comment_id, :comment)
  end
end
