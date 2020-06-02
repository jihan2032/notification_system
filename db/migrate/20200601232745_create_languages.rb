class CreateLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :languages do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.integer :users_count, default: 0

      t.timestamps
    end
  end
end
