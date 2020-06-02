class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.references :provider, null: false, foreign_key: true
      t.json :texts, null: false
      t.string :kind, default: 'group'
      t.integer :user_notifications_count, default: 0

      t.timestamps
    end
  end
end
