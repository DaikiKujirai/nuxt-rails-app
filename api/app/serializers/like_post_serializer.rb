class LikePostSerializer < ActiveModel::Serializer
  attributes %i[id user_id post_id]

  belongs_to :user
  belongs_to :post
end
