class Post < ApplicationRecord
  belongs_to :user
  has_many   :likes, dependent: :destroy

  validates :content, presence: true

  # class << self
  #   def get_comment_and_user_data(post_comments)
  #     post_comments.joins(:user).select("
  #                                 comments.id,
  #                                 comments.user_id,
  #                                 comments.post_id,
  #                                 comments.comment_id,
  #                                 comments.content,
  #                                 comments.created_at,
  #                                 users.name AS user_name
  #                               ")
  #     # post_comments.joins(:like_comments).select("
  #     #                                     like_comments.id
  #     #                                   ")
  #   end
  # end
  class << self
    def find_user_posts(user_id)
      where(user_id: user_id, post_id: 0).order(created_at: :desc)
    end

    def find_user_like_posts(user_likes)
      user_like_posts = []
      user_likes.each do |like|
        user_like_posts.push(Post.find(like.post_id))
      end
      return user_like_posts
    end

    def find_user_comments(user_id)
      where(user_id: user_id).where.not(post_id: 0).order(created_at: :desc)
    end
  end

end
