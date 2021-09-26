class Api::V1::RelationshipsController < ApplicationController
  include Pagination

  def create
    current_user = User.find(params[:id])
    other_user   = User.find(params[:user_id])

    if current_user.follow(other_user)
      other_user.create_notification_follow!(current_user, params[:uid])
      render json: { success_message: 'フォローしました' }
    else
      render json: { errors_message: '失敗しました' }
    end
  end

  def destroy
    relationship = Relationship.find_by(user_id: params[:id], follow_id: params[:user_id])
    if relationship.destroy
      render json: { success_message: 'フォローを解除しました' }
    else
      render json: { errors_message: '失敗しました' }
    end
  end

  def find_following
    user       = User.find(params[:id])
    following  = user.followings.page(params[:page]).per(15)
    pagination = resources_with_pagination(following)
    object     = { following: following, kaminari: pagination }
    render json: object
  end

  def find_followers
    user       = User.find(params[:id])
    followers  = user.followers.page(params[:page]).per(15)
    pagination = resources_with_pagination(followers)
    object     = { followers: followers, kaminari: pagination }
    render json: object
  end

  private

  def relationship_params
    params.require(:relationships).permit(:user_id, :follow_id)
  end

end
