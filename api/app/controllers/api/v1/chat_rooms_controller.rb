class Api::V1::ChatRoomsController < ApplicationController
  include Pagination
  def show
    current_user = User.find(params[:id])

    if params[:id] != params[:user_id]
      other_user = User.find(params[:user_id])
      room_id    = ChatRoom.make_room_id(current_user.uid, other_user.uid)

      unless current_user.chat_rooms.exists?(name: room_id)
        ChatRoom.create!(user_id: current_user.id, name: room_id, distination_user_id: other_user.id)
        ChatRoom.create!(user_id: other_user.id, name: room_id, distination_user_id: current_user.id)
      end
    end

    chat_rooms = current_user.chat_rooms.updated_desc.page(params[:page]).per(15)
    pagination = resources_with_pagination(chat_rooms)
    object     = { chat_rooms: chat_rooms, kaminari: pagination }
    render json: object
  end

  def update
    chat_room = ChatRoom.find_by(
      user_id: params[:user_id],
      distination_user_id: params[:distination_user_id]
    )
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
