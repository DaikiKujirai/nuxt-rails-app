class Post < ApplicationRecord
  belongs_to :user

  has_many :likes        , dependent: :destroy
  has_many :notifications, dependent: :destroy

  has_many :comments, class_name: 'Post', foreign_key: 'post_id', dependent: :destroy

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
  end

  # notification
  def create_notification_like!(current_user, post, other_user_uid)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ?", current_user.id, user_id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.new(
                                                            post_id:    id     ,
                                                            visited_id: user_id,
                                                            action:     'like'
                                                          )
      notification.save if notification.valid?
      create_push_notification_like!(current_user, post, other_user_uid)
    end
  end

  def create_push_notification_like!(current_user, post, other_user_uid)
    ActionCable.server.broadcast other_user_uid, notification_data: post  ,
                                                 category:          'like',
                                                 user_name:         current_user.name
  end

  def create_notification_comment!(current_user, visited_id, post, other_user_uid)
    notification = current_user.active_notifications.new(
                                                          post_id:    id        ,
                                                          visited_id: visited_id,
                                                          action:     'comment'
                                                        )
    notification.save if notification.valid?
    create_push_notification_comment!(current_user, post, other_user_uid)
  end

  def create_push_notification_comment!(current_user, post, other_user_uid)
    ActionCable.server.broadcast other_user_uid, notification_data: post     ,
                                                 category:          'comment',
                                                 user_name:         current_user.name
  end
end
