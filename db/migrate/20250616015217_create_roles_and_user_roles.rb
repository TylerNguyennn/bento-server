class CreateRolesAndUserRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :roles do |t|
      t.string :name, null: false
      t.timestamps
    end

    add_index :roles, :name, unique: true

    create_table :user_roles do |t|
      t.references :user, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
