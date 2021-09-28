class Api::V1::ChatsController < ApplicationController
  include Pagination
  def show
    current_user = User.find(params[:user_id])
    other_user   = User.find(params[:id])
    user_rooms   = UserRoom.find_by(user_id: current_user.id, partner_id: other_user.id)

    unless user_rooms.nil?
      room = user_rooms.room
    else
      room = Room.new
      room.save
      UserRoom.create!(user_id: current_user.id, partner_id: other_user.id  , room_id: room.id)
      UserRoom.create!(user_id: other_user.id  , partner_id: current_user.id, room_id: room.id)
    end

    chats  = room.chats
    object = { chats: chats, room_id: room.id, user: other_user }
    render json: object
  end

  def create
    current_user = User.find(params[:user_id])
    chat         = current_user.chats.new(chat_params)
    if chat.save
      ActionCable.server.broadcast params[:uid], notification_data: chat,
                                                 category:          'chat'   ,
                                                 user_name:         params[:user_name]
      render json: chat
    else
      render json: errors.message
    end
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

  def update_checked
    chat = Chat.find(params[:id])
    chat.update_attributes(checked: true)
    ActionCable.server.broadcast params[:uid], chat: chat, category: 'read'
    render json: { success_message: '既読しました' }
  end

  def find_my_chat_rooms
    current_user = User.find(params[:user_id])
    user_rooms   = current_user.user_rooms.includes(:partner, { room: :chats }).page(params[:page]).per(15)
    pagination   = resources_with_pagination(user_rooms)
    object       = { chat_rooms: user_rooms.as_json(include: [:partner, { room: { include: :chats} }]), kaminari: pagination }
    render json: object
  end

  def find_last_message
    room = Room.find(params[:id])
    render json: room.chats.last
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :user_id, :partner_id, :room_id)
  end
end
