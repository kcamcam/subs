class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :uid, null: false

      t.timestamps
    end
    add_index :users, :uid, unique: true
  end
end
