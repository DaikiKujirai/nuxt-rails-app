class Api::V1::UserRoomsController < ApplicationController
  include Pagination
  def show
    current_user = User.find(params[:id])
    user_rooms   = current_user.user_rooms.includes(:partner).page(params[:page]).per(15)
    pagination   = resources_with_pagination(user_rooms)
    object       = { user_rooms: user_rooms.as_json(include: :partner), kaminari: pagination }
    render json: object
  end

  private

  def user_room_params
    params.require(:user_room).permit(:user_id, :partner_id, :room_id, :last_message)
  end
end
