class CreateUserNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :user_notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :notification, null: false, foreign_key: true
      t.references :provider, null: false, foreign_key: true
      t.text :content, null: false
      t.string :lang_code, null: false
      t.string :notification_type, null: false
      t.boolean :incorrect_lang, default: false

      t.timestamps
    end
  end
end
