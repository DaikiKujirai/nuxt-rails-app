class Post < ApplicationRecord
  belongs_to :user
  has_many   :likes, dependent: :destroy

  validates :content, presence: true

  class << self
    def find_user_posts(user_id)
      joins(:user).select("posts.*,users.name AS user_name")
                  .where(user_id: user_id, post_id: 0).order(created_at: :desc)
    end

    def find_user_like_posts(user_likes)
      user_like_posts = []
      user_likes.each do |like|
        user_like_posts.push(Post.find(like.post_id))
      end
      return user_like_posts
    end

    def find_user_comments(user_id)
      joins(:user).select("posts.*,users.name AS user_name")
                  .where(user_id: user_id).where.not(post_id: 0).order(created_at: :desc)
    end
  end

end
