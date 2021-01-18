class CreateBrands < ActiveRecord::Migration[6.0]
  def change
    create_table :brands do |t|
      t.text :image
      t.string :name
      t.string :info
      t.string :category

      t.timestamps
    end

    add_index :brands, :name, unique: true
  end
end
