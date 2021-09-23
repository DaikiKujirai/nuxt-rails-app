class ChatRoom < ApplicationRecord
  belongs_to :user
  belongs_to :distination_user, class_name: 'User'

  has_many :notifications

  scope :updated_desc , -> { order(updated_at: :desc) }

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
