class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.references :brand, null: true, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.decimal :amount
      t.integer :frequency
      t.string :unit
      t.date :first_bill

      t.timestamps
    end
  end
end
