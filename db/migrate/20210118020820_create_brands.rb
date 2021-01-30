class CreateBrands < ActiveRecord::Migration[6.0]
  def change
    create_table :brands do |t|
      t.text      :image
      t.string    :name
      t.string    :url
      t.string    :info
      t.string    :category
      t.boolean   :custom, default: false
      t.integer   :created_by, null: false
      t.integer   :released_by
      t.datetime  :released_at

      t.index     :created_by
      t.index     :custom

      t.timestamps
    end

    add_index :brands, :name, unique: true
  end
end
