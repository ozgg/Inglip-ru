class CreateLexemes < ActiveRecord::Migration[5.2]
  def up
    unless Lexeme.table_exists?
      create_table :lexemes do |t|
        t.timestamps
        t.references :lexeme_type, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
        t.boolean :declinable, default: true, null: false
        t.integer :flags, default: 0, null: false
        t.integer :wordforms_count, limit: 2, default: 0, null: false
        t.string :context
        t.string :body, null: false
      end

      add_index :lexemes, [:body, :lexeme_type_id, :context], unique: true
    end
  end

  def down
    if Lexeme.table_exists?
      drop_table :lexemes
    end
  end
end
