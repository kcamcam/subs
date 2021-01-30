class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string      :uid, null: false, unique: true
      t.string      :name
      t.string      :nickname
      t.string      :given_name
      t.string      :family_name
      t.string      :locale
      t.string      :email
      t.text        :image
      t.boolean     :enabled, default: true
      t.boolean     :admin, default: false

      t.index       :uid

      t.timestamps
    end

    add_foreign_key :brands, :users, column: :created_by
    add_foreign_key :brands, :users, column: :released_by
  end
end
