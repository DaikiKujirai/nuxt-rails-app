class PostSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :content, :created_at, :user
  belongs_to :user
  has_many :comments

  def comments
    object.comments.where(comment_id: 0).order(id: :desc)
  end
end