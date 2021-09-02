class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  class << self
    def find_user_likes(user_id)
      where(user_id: user_id).order(created_at: :desc)
    end
  end
end
