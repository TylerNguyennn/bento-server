class AddFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :role, :string, null: false, default: 'buyer'
    add_column :users, :name, :string
    add_column :users, :status, :string, default: 'active'
  end
end
