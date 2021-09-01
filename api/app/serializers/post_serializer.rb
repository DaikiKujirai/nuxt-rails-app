class PostSerializer < ActiveModel::Serializer
  attributes %i[id user_id post_id content created_at post_user_name]

  belongs_to :user
  has_many :likes

  def post_user_name
    User.find(object.user_id).name
  end
end
