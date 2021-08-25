class UserSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :posts
  has_many :comments
  has_many :likes
end
