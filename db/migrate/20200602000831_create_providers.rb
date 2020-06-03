class CreateProviders < ActiveRecord::Migration[6.0]
  def change
    create_table :providers do |t|
      t.string :name, null: false
      t.string :type, null: false
      t.integer :min_limit, null: false
      t.integer :user_notifications_count, default: 0
      t.integer :last_min_count, default: 0
      t.datetime :last_sync

      t.timestamps
    end
  end
end
