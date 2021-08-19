class PostSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :content, :created_at

  belongs_to :user
  has_many :comments
end
