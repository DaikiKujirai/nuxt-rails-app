class Api::V1::ChatsController < ApplicationController
  def create
    chat = Chat.new(chat_params)

    if chat.save
      ActionCable.server.broadcast 'room_channel', chat: chat.message
      render json: chat
    else
      render json: chat.errors
    end
  end
end
