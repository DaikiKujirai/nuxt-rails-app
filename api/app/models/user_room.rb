class UserRoom < ApplicationRecord
  belongs_to :user
  belongs_to :partner, class_name: 'User', foreign_key: 'partner_id'
  default_scope -> { order(updated_at: :desc) }
end
