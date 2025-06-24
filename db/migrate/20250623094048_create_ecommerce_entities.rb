class CreateEcommerceEntities < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :invoice_id
      t.datetime :order_date, null: false
      t.decimal :total_price, precision: 10, scale: 2, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    create_table :order_items do |t|
      t.decimal :price, precision: 10, scale: 2, null: false
      t.string :download_url
      t.references :asset, null: false, foreign_key: { to_table: :products }
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end

    create_table :tags do |t|
      t.string :name, null: false
      t.text :description
      t.references :parent_tag, foreign_key: { to_table: :tags }

      t.timestamps
    end
    add_index :tags, :name, unique: true

    create_table :asset_tags do |t|
      t.references :asset, null: false, foreign_key: { to_table: :products }
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
