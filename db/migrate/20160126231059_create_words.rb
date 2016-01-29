class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :stress
      t.string :body, null: false
    end

    add_index :words, :body
    execute "create index words_reversed_body_idx on words using btree (reverse(body));"
  end
end
