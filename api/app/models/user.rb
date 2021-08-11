require "validator/email_validator"

class User < ApplicationRecord
  before_validation :downcase_email

  # has_secure_password

  validates :name,  presence: true,
                    length: { maximum: 30, allow_blank: true }
  validates :email, presence: true,
                    email: { allow_blank: true }
  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/
  # validates :uid,  presence: true,
  #                       length: { minimum: 8 },
  #                       format: {
  #                         with: VALID_PASSWORD_REGEX,
  #                         message: :invalid_password
  #                       },
  #                       allow_nil: true

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

  private

  def downcase_email
    self.email.downcase! if email
  end
end
