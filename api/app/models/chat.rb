class Chat < ApplicationRecord
  belongs_to :user

  has_many :notifications

  class << self
    def read_all_chats(unread_chats, other_user_id)
      unread_chats.each do |chat|
        chat.update_attributes(checked: true)
      end
    end
  end
end
