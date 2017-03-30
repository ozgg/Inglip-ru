class CreateLexemes < ActiveRecord::Migration[5.0]
  def change
    create_table :lexemes do |t|
      t.timestamps
      t.references :lexeme_group, foreign_key: true, null: false, on_update: :cascade, on_delete: :cascade
      t.boolean :locked, default: false, null: false
      t.boolean :declinable, default: true, null: false
      t.boolean :like_adjective, default: false, null: false
      t.integer :flags, default: 0, null: false
      t.string :body, null: false
      t.string :context, default: '', null: false
    end

    add_index :lexemes, :like_adjective
    add_index :lexemes, [:body, :context], unique: true
  end
end
