class CreateWordforms < ActiveRecord::Migration[5.2]
  def up
    unless Wordform.table_exists?
      create_table :wordforms do |t|
        t.timestamps
        t.references :lexeme, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
        t.references :word, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
        t.integer :flags, default: 0, null: false
      end
    end
  end

  def down
    if Wordform.table_exists?
      drop_table :wordforms
    end
  end
end
