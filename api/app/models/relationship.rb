class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User'

  validates :user_id  , presence: true
  validates :follow_id, presence: true

  class << self
    def follow(user, other_user)
      relationships.create(user_id: user, follow_id: other_user.id)
    end
  end
end
