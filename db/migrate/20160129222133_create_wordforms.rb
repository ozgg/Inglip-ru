class CreateWordforms < ActiveRecord::Migration
  def change
    create_table :wordforms do |t|
      t.references :lexeme, index: true, foreign_key: true, null: false
      t.references :word, index: true, foreign_key: true, null: false
      t.integer :indicator, limit: 2, null: false
    end
  end
end
