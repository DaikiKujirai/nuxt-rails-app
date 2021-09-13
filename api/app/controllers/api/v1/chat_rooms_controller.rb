class Api::V1::ChatRoomsController < ApplicationController
  def show
    current_user = User.find(params[:id])

    if params[:page] != 'chats'
      other_user = User.find(params[:user_id])
      room_id    = ChatRoom.make_room_id(current_user.uid, other_user.uid)

      unless current_user.chat_rooms.exists?(name: room_id)
        ChatRoom.create!(user_id: current_user.id, name: room_id, distination_user_id: other_user.id)
        ChatRoom.create!(user_id: other_user.id, name: room_id, distination_user_id: current_user.id)
      end
    end

    chat_rooms = current_user.chat_rooms.where(user_id: current_user.id)
    render json: chat_rooms
  end
end