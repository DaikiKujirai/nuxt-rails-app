class Api::V1::LikePostsController < ApplicationController
  def create
    like = LikePost.new(like_post_params)
    if like.save
      render json: like
    else
      render json: { error_message: '失敗しました' }
    end
  end

  def destroy
    like = LikePost.find_by(user_id: params[:user_id], post_id: params[:post_id])
    if like.destroy
      render json: like
    else
      render json: { errors_message: '失敗しました' }
    end
  end

  private

  def like_post_params
    params.require(:like_post).permit(:user_id, :post_id)
  end
end
