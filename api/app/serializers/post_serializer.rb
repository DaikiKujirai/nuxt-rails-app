class PostSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :content, :created_at, :user

  belongs_to :user
  has_many :comments
  has_many :likes, as: :likeable

  def comments
    object.comments.where(comment_id: 0).order(created_at: :desc)
  end
end