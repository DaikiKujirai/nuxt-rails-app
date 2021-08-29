class LikeCommentSerializer < ActiveModel::Serializer
  attributes %i[id user_id comment_id]

  belongs_to :user
  belongs_to :comment
end
