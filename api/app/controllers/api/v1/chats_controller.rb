class Api::V1::ChatRoomsController < ApplicationController
  include Pagination
  def show
    current_user = User.find(params[:id])
    other_user   = User.find(params[:user_id])
    rooms        = current_user.user_rooms.pluck(:room_id)
    user_rooms   = UserRoom.find_by(user_id: user.id, room_id: rooms)
    if params[:id] != params[:user_id]

      unless current_user.chat_rooms.exists?(name: room_id)
        ChatRoom.create!(user_id: current_user.id, name: room_id)
        ChatRoom.create!(user_id: other_user.id, name: room_id)
      end
    end

    chat_rooms = current_user.chat_rooms.includes(:distination_user).updated_desc.page(params[:page]).per(15)
    pagination = resources_with_pagination(chat_rooms)
    object     = { chat_rooms: chat_rooms.as_json(include: :distination_user), kaminari: pagination }
    render json: object
  end

  def update
    chat_room = ChatRoom.find_by(
      user_id: params[:user_id],
      distination_user_id: params[:distination_user_id]
    )
    # actioncable
    ActionCable.server.broadcast params[:distination_user][:uid], notification_data: chat_room,
                                                                  category:          'chat'   ,
                                                                  user_name:         params[:distination_user][:name]

    distination_chat_room = ChatRoom.find_by(
      user_id: params[:distination_user_id],
      distination_user_id: params[:user_id]
    )
    chat_room.created_at = Time.now
    chat_room.update(chat_room_params)
    render json: { success_messages: '更新しました' }
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:user_id, :name, :distination_user_id)
  end
end
