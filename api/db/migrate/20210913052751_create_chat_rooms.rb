class CreateChatRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_rooms do |t|
      t.references :user, foreign_key: true
      t.integer    :distination_user_id
      t.string     :name, null: false

      t.timestamps
    end
  end
end
