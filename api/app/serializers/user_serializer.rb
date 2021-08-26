class UserSerializer < ActiveModel::Serializer
  attributes %i[id name]

  has_many :posts
  has_many :comments
  has_many :like_posts
  has_many :like_comments
end
