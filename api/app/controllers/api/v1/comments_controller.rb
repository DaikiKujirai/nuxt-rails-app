class Api::V1::CommentsController < ApplicationController

  def show
    comment = Comment.where(comment_id: params[:id])
    render json: comment
  end

  def create
    comment = Comment.new(comment_params)
    comment.user_id = User.find_by(uid: params[:user_uid]).id
    if comment.save
      render json: comment
    else
      render json: comment.errors.messages
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :comment_id, :content)
  end
end
