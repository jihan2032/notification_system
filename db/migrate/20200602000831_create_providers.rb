class CreateProviders < ActiveRecord::Migration[6.0]
  def change
    create_table :providers do |t|
      t.string :name, null: false
      t.string :type, null: false
      t.integer :min_limit, null: false

      t.timestamps
    end
  end
end
