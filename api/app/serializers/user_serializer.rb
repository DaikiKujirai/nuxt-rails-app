class UserSerializer < ActiveModel::Serializer
  attributes %i[id name avatar introduction is_active admin]

  has_many :posts
  has_many :likes
end
