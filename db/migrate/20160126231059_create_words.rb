class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.timestamps null: false
      t.references :lexeme, index: true, foreign_key: true, null: false
      t.string :stress
      t.string :body, null: false
      t.json :data
    end

    add_index :words, :body
    execute "create index words_reversed_body_idx on words using btree (reverse(body));"
  end
end
