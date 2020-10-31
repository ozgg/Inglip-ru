# frozen_string_literal: true

# Add lexeme_type_id cached field to wordforms table
class AddLexemeTypeToWordform < ActiveRecord::Migration[6.0]
  def change
    add_reference :wordforms, :lexeme_type, foreign_key: { on_update: :cascade, on_delete: :cascade }

    reversible do |direction|
      direction.up do
        execute "
        update wordforms w
        set lexeme_type_id = (
          select lexeme_type_id
          from lexemes where lexemes.id = w.lexeme_id
        )
        "

        change_column_null :wordforms, :lexeme_type_id, false
      end
    end

    add_index :wordforms, %i[flags lexeme_type_id word_id]
  end
end
