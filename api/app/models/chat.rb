class Chat < ApplicationRecord
  belongs_to :user

  has_many :notifications

  # default_scope -> { order(created_at: :desc) }
end
