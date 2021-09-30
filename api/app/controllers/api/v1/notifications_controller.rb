class Api::V1::NotificationsController < ApplicationController
  include Pagination
  def show
    current_user  = User.find(params[:id])
    notifications = current_user.passive_notifications.includes(:post, :visitor).where(checked: false).page(params[:page]).per(15)
    notifications.each do |notification|
      notification.update_attributes(checked: true)
    end
    pagination    = resources_with_pagination(notifications)
    object        = { notifications: notifications.as_json(include: [:post, :visitor]), kaminari: pagination }
    render json: object
  end

  def create
    current_user = User.find(params[:chat][:id])
    other_user   = User.find(params[:chat][:user_id])
    other_user.create_notification_chat!(current_user)
    render json: { success_messages: '成功しました' }
  end

  def find_notifications_count
    current_user        = User.find(params[:id])
    notifications_count = current_user.passive_notifications.where(checked: false).count
    render json: notifications_count
  end
end
