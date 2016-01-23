class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.integer :role, limit: 2, null: false
      t.timestamps null: false
    end

    add_index :user_roles, [:user_id, :role], unique: true
  end
end
