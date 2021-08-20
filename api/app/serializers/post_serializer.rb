class PostSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :content, :created_at, :user
  belongs_to :user
  has_many :comments
  # class UserSerializer < ActiveModel::Serializer
  #   attributes :id, :name
  #   has_many :posts
  #   has_many :comments
  # end
end
