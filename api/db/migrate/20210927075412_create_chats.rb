class CreateChats < ActiveRecord::Migration[6.0]
  def change
    create_table :chats do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.string     :message                , null: false
      t.boolean    :checked                , null: false, default: false

      t.timestamps
    end
  end
end
