class RoomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "room_channel"
    stream_from "#{params[:uid]}"
  end

  def unsubscribed
    stop_all_streams
  end

  def post(data)
    # RoomChannel.broadcast_to("room_channel", data)
    RoomChannel.broadcast_to("#{params[:uid]}", data)
  end
end
