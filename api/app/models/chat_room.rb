class ChatRoom < ApplicationRecord
  belongs_to :user

  scope :updated_desc , -> { order(updated_at: :desc) }

  class << self
    def make_room_id(current_user_uid, other_user_uid)
      if current_user_uid > other_user_uid
        return current_user_uid + '-' + other_user_uid
      else
        return other_user_uid + '-' + current_user_uid
      end
    end

    def find_my_chat_rooms(current_user)
      current_user.chat_rooms.where(user_id: current_user.id).updated_desc
    end
  end

end
