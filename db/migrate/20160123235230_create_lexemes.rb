class CreateLexemes < ActiveRecord::Migration
  def change
    create_table :lexemes do |t|
      t.timestamps null: false
      t.integer :part, limit: 2, null: false
      t.integer :obscenity, limit: 2, null: false, default: 0
      t.boolean :verified, null: false, default: false
      t.string :body, null: false
      t.string :context
      t.json :data
    end

    add_index :lexemes, [:body, :part]
  end
end
