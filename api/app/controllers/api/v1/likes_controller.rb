class Api::V1::LikesController < ApplicationController
  include Pagination
  def show
    likes      = Like.includes(:user).where(post_id: params[:id]).page(params[:page]).per(15)
    pagination = resources_with_pagination(likes)
    object     = { likes: likes.as_json(include: :user), kaminari: pagination }
    render json: object
  end

  def create
    like = Like.new(like_params)
    if like.save
      post         = Post.find(params[:post_id])
      current_user = User.find(params[:user_id])
      post.create_notification_like!(current_user, post, params[:uid]) if post.user_id != current_user.id
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
