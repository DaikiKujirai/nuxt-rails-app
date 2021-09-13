class ChatRoom < ApplicationRecord
  belongs_to :user

  class << self
    def make_room_id(current_user_uid, other_user_uid)
      if current_user_uid > other_user_uid
        return current_user_uid + '-' + other_user_uid
      else
        return other_user_uid + '-' + current_user_uid
      end
    end
  end
end
