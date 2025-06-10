class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.references :seller, null: false, foreign_key: { to_table: :users }
      t.string :title, null: false
      t.text :description
      t.decimal :price, precision: 10, scale: 2, null: false
      t.string :category, null: false
      t.text :tags
      t.float :rating_avg, default: 0
      t.boolean :published, default: true

      t.timestamps
    end
  end
end
