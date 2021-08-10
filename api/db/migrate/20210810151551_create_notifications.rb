class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :visitor, null: false
      t.integer :visited, null: false
      t.integer :post
      t.integer :comment
      t.string  :action , null: false
      t.boolean :checked, null: false, default: false

      t.timestamps
    end
  end
end
