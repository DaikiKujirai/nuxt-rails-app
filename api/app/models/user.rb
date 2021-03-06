require "validator/email_validator"

class User < ApplicationRecord

  has_many :posts , dependent: :delete_all
  has_many :likes , dependent: :delete_all
  has_many :user_rooms
  has_many :chats

  has_many :relationships, dependent: :delete_all
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followings , through: :relationships           , source: :follow
  has_many :followers  , through: :reverse_of_relationships, source: :user

  has_many :active_notifications , class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  mount_uploader :avatar     , AvatarUploader
  mount_uploader :cover_image, CoverImageUploader

  before_validation :downcase_email

  validates :name , presence: true, length: { maximum: 30, allow_blank: true }
  validates :email, presence: true, email: { allow_blank: true }
  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/
  validates :uid  , presence: true

  class << self
    # emailからアクティブなユーザーを返す
    def find_activated(email)
      find_by(email: email, is_active: true)
    end
  end

  # 自分以外の同じemailのアクティブなユーザーがいる場合にtrueを返す
  def email_activated?
    users = User.where.not(id: id)
    users.find_activated(email).present?
  end

  def follow(other_user)
    Relationship.create(user_id: id, follow_id: other_user.id)
  end

  def create_notification_follow!(current_user, other_user_uid)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ?", current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
                                                          visited_id: id,
                                                          action: 'follow'
                                                        )
      notification.save if notification.valid?
      create_push_notification_follow!(current_user, other_user_uid)
    end
  end

  def create_push_notification_follow!(current_user, other_user_uid)
    ActionCable.server.broadcast other_user_uid, category:  'follow',
                                                 user_name: current_user.name
  end

  def create_notification_chat!(current_user)
    notification = current_user.active_notifications.new(
                                                        visited_id: id,
                                                        action: 'chat'
                                                      )
    notification.save if notification.valid?
  end

  private

  def downcase_email
    self.email.downcase! if email
  end
end
