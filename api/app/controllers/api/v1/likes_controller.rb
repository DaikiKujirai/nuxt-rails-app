class Api::V1::LikesController < ApplicationController

  def show
    likes = Like.where(post_id: params[:id])
    render json: likes
  end

  def create
    like = Like.new(like_params)
    if like.save
      render json: like
    else
      render json: { error_message: '失敗しました' }
    end
  end

  def destroy
    like = Like.find_by(user_id: params[:user_id], post_id: params[:post_id])
    if like.destroy
      render json: like
    else
      render json: { errors_message: '失敗しました' }
    end
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end
end
