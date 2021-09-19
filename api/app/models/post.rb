class Post < ApplicationRecord
  belongs_to :user

  has_many :likes        , dependent: :destroy
  has_many :notifications, dependent: :destroy

  mount_uploader :image, ImageUploader

  validates :content, presence: true

  default_scope -> { order(created_at: :desc) }

  # post
  class << self
    def find_posts
      where(post_id: 0)
    end

    def find_home_posts(current_user)
      where(user_id: [current_user.id, *current_user.following_ids]).where(post_id: 0)
    end

    def find_post_comments(post_id)
      where(post_id: post_id)
    end

    def find_user_posts(user_id)
      where(user_id: user_id, post_id: 0)
    end

    def find_user_comments(user_id)
      where(user_id: user_id).where.not(post_id: 0)
    end

    def find_user_posts_have_image(user_id)
      where(user_id: user_id).where.not(image: nil)
    end

    def find_user_like_posts(user_likes)
      user_like_posts = []
      user_likes.each do |like|
        user_like_posts.push(Post.find(like.post_id))
      end
      return user_like_posts
    end
  end

  # notification
  def create_notification_like!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ?", current_user.id, user_id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.new(
                                                          　post_id:    id,
                                                          　visited_id: user_id,
                                                          　action:     'like'
                                                          )
      if notification.visitor_id == notification.visited_id
        return
      end
      notification.save if notification.valid?
    end
  end

  # def create_notification_comment!(current_user, post_id, visited_id)
  #   post_id_and_user_id = Post.select(:user_id).find(id)
  #   save_notification_comment!(current_user, post_id, user_id) if post_id_and_user_id.blank?
  # end

  def create_notification_comment!(current_user, visited_id)
    notification = current_user.active_notifications.new(
                                                          post_id:    id        ,
                                                          visited_id: visited_id,
                                                          action:     'comment'
                                                        )
    notification.save if notification.valid?
  end
end
