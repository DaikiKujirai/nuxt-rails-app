class CreateLikeComments < ActiveRecord::Migration[6.0]
  def change
    create_table :like_comments do |t|
      t.references :user   , foreign_key: true
      t.references :comment, foreign_key: true

      t.timestamps
    end
  end
end
