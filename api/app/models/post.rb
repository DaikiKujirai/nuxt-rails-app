class Post < ApplicationRecord
  belongs_to :user

  has_many :comments     , dependent: :destroy
  has_many :like_posts   , dependent: :destroy

  validates :content, presence: true

  class << self
    def get_comment_and_user_data(post_comments)
      post_comments.joins(:user).select("
                                  comments.id,
                                  comments.user_id,
                                  comments.post_id,
                                  comments.comment_id,
                                  comments.content,
                                  comments.created_at,
                                  users.name AS user_name
                                ")
      # post_comments.joins(:like_comments).select("
      #                                     like_comments.id
      #                                   ")
    end
  end
end
