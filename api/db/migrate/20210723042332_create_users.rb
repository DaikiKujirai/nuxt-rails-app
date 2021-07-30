class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string  :name        , null: false
      t.string  :email       , null: false
      t.string  :password    , null: false
      t.string  :introduction, null: false, default: "よろしくお願いします。"
      t.boolean :is_active   , null: false, default: false
      t.boolean :admin       , null: false, default: false

      t.timestamps
    end
  end
end
