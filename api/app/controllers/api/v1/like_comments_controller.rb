class Api::V1::LikeCommentsController < ApplicationController
  def create
    like = Like.new(like_params)
    if like.save
      user_likes = Like.where(user_id: like.user_id)
      render json: user_likes.as_json
    else
      render json: { error_message: '失敗しました' }
    end
  end

  def destroy
    like = Like.find_by(user_id: params[:id])
    if like.destroy
      user_likes = Like.where(user_id: like.user_id)
      render json: user_likes.as_json
    end
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :comment_id)
  end
end
