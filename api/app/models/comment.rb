class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_many :like_comments, dependent: :destroy
end
