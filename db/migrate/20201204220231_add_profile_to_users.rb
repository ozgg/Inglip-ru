class AddProfileToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :profile, :jsonb, default: {}, null: false
  end
end
