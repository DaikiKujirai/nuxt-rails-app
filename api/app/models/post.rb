class Post < ApplicationRecord
  belongs_to :user
  has_many   :likes, dependent: :destroy
  mount_uploader :image, ImageUploader

  validates :content, presence: true

  scope :select_detail, -> { left_joins(:user).select("
                                                posts.*,
                                                users.name        AS user_name  ,
                                                users.avatar      AS user_avatar,
                                                users.cover_image AS user_cover
                                                ")}

  scope :created_desc , -> { order(created_at: :desc) }

  class << self
    def find_posts
      select_detail.where(post_id: 0).created_desc
    end

    def find_post_comments(post_id)
      select_detail.where(post_id: post_id).created_desc
    end

    def find_user_posts(user_id)
      select_detail.where(user_id: user_id, post_id: 0).created_desc
    end

    def find_user_like_posts(user_likes)
      user_like_posts = []
      user_likes.each do |like|
        user_like_posts.push(Post.select_detail.find(like.post_id))
      end
      return user_like_posts
    end

    def find_user_comments(user_id)
      select_detail.where(user_id: user_id)
                   .where.not(post_id: 0)
                   .created_desc
    end

  end
end
