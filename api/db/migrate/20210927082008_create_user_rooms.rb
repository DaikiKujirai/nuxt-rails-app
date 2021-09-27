class CreateUserRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :user_rooms do |t|
      t.references :user   , foreign_key: true
      t.references :room   , foreign_key: true
      t.integer    :partner                   , null: false

      t.timestamps
    end
  end
end
