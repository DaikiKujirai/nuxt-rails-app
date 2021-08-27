require "validator/email_validator"

class User < ApplicationRecord

  has_many :posts         , dependent: :destroy
  has_many :comments      , dependent: :destroy
  has_many :like_posts    , dependent: :destroy
  has_many :like_comments , dependent: :destroy
  has_many :relationships
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'

  has_many :followings    , through: :relationships           , source: :follow
  has_many :followers     , through: :reverse_of_relationships, source: :user

  before_validation :downcase_email

  validates :name , presence: true,
                    length: { maximum: 30, allow_blank: true }
  validates :email, presence: true,
                    email: { allow_blank: true }
  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/
  validates :uid,  presence: true

  ## methods
  # class method  ###########################
  class << self
    # emailからアクティブなユーザーを返す
    def find_activated(email)
      find_by(email: email, is_active: true)
    end
  end
  # class method end #########################

  # 自分以外の同じemailのアクティブなユーザーがいる場合にtrueを返す
  def email_activated?
    users = User.where.not(id: id)
    users.find_activated(email).present?
  end

  def follow(other_user)
    unless self == other_user
      self.relationships.create(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  private

  def downcase_email
    self.email.downcase! if email
  end
end
