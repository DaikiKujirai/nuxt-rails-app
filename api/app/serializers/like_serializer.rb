class LikeSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :likeable_id, :likeable_type

  belongs_to :user
  belongs_to :post
  belongs_to :comment
end
