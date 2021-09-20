class Api::V1::LikesController < ApplicationController
  include Pagination
  def create
    like = Like.new(like_params)
    if like.save
      post         = Post.find(params[:post_id])
      current_user = User.find(params[:user_id])
      post.create_notification_like!(current_user)
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

  def render_is_like_and_likes_count
    post        = Post.find(params[:id])
    likes_count = post.likes.count
    if Like.exists?(user_id: params[:user_id], post_id: post.id)
      object    = { is_like: true, likes_count: likes_count }
      render json: object
    else
      object    = { is_like: false, likes_count: likes_count }
      render json: object
    end
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end
end
