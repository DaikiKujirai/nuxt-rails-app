class Api::V1::NotificationsController < ApplicationController
  include Pagination
  def show
    current_user  = User.find(params[:id])
    notifications = current_user.passive_notifications.page(params[:page]).per(10)
    notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
    pagination    = resources_with_pagination(notifications)
    object        = { notifications: notifications, kaminari: pagination }
    render json: object
  end

  def find_notifications_count
    current_user        = User.find(params[:id])
    notifications_count = current_user.passive_notifications.where(checked: false).count
    render json: notifications_count
  end
end
