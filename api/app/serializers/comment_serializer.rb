class CommentSerializer < ActiveModel::Serializer
  attributes %i[id user_id post_id comment_id content created_at]

  belongs_to :user
  belongs_to :post
  has_many :like_comments
end
