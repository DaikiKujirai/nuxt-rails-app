class PostSerializer < ActiveModel::Serializer
  attributes %i[id user_id content created_at]

  belongs_to :user
  has_many :comments
  has_many :like_posts

  def comments
    object.comments.where(comment_id: 0).order(created_at: :desc)
  end
end