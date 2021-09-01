class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.references :user   , foreign_key: true
      t.integer    :post_id                   , null: false, default: 0
      t.string     :content                   , null: false
      t.string     :image

      t.timestamps
    end
  end
end
