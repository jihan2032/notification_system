class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.string :phone
      t.references :language, null: false, foreign_key: true
      t.integer :user_notifications_count, default: 0

      t.timestamps
    end
  end
end
