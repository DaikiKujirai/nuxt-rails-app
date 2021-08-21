class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user      , foreign_key: true
      t.references :post      , foreign_key: true
      t.integer    :comment_id                   , default: 0
      t.string     :content                                  , null: false

      t.timestamps
    end
  end
end
