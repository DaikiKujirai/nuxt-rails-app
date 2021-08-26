class Api::V1::LikeCommentsController < ApplicationController
  def create
    like = LikeComment.new(like_comment_params)
    if like.save
      user_likes = LikeComment.where(user_id: like.user_id)
      render json: user_likes
    else
      render json: { error_message: '失敗しました' }
    end
  end

  def destroy
    like = LikeComment.find_by(user_id: params[:user_id], comment_id: params[:comment_id])
    if like.destroy
      user_likes = LikeComment.where(user_id: like.user_id)
      render json: user_likes.as_json
    else
      render json: { errors_message: '失敗しました' }
    end
  end

  private

  def like_comment_params
    params.require(:like_comment).permit(:user_id, :comment_id)
  end
end
