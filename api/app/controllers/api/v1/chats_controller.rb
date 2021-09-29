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

    chats        = room.chats
    unread_chats = chats.where(user_id: other_user.id, checked: false)

    unless unread_chats.blank?
      Chat.read_all_chats(unread_chats, other_user.id)
      ActionCable.server.broadcast params[:uid], chats: chats, category: 'read_all'
    end

    object = { chats: chats, room_id: room.id, user: other_user }
    render json: object
  end

  def create
    current_user = User.find(params[:current_user_id])
    chat         = current_user.chats.new(chat_params)
    last_message = chat.message.truncate(15)
    if chat.save
      # last_message = last_message.truncate(15) if last_message.length >= 15
      user_room         = UserRoom.find_by(user_id: current_user.id   , partner_id: params[:user][:id])
      partner_user_room = UserRoom.find_by(user_id: params[:user][:id], partner_id: current_user.id)
      user_room.update_attributes(last_message: last_message)
      partner_user_room.update_attributes(last_message: last_message)

      ActionCable.server.broadcast params[:user][:uid], notification_data: chat  ,
                                                        category:          'chat',
                                                        user_name:         params[:user][:name]

      render json: chat
    else
      render json: errors.message
    end
  end

  def update
    chat = Chat.find(params[:id])
    chat.update_attributes(checked: true)
    ActionCable.server.broadcast params[:uid], chat: chat, category: 'read'
    render json: { success_message: '既読' }
  end

  def find_unread_chats_count_in_sidebar
    current_user = User.find(params[:id])
    rooms        = current_user.user_rooms.pluck(:room_id)
    unread_chats = Chat.where(room_id: [*rooms], checked: false).where.not(user_id: current_user.id)
    render json: unread_chats
  end

  def find_unread_chats_count_in_room
    room         = Room.find(params[:id])
    unread_chats = room.chats.where(user_id: params[:partner_id], checked: false)
    render json: unread_chats
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :user_id, :room_id, :checked)
  end
end
