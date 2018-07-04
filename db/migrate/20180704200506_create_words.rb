class CreateWords < ActiveRecord::Migration[5.2]
  def up
    unless Word.table_exists?
      create_table :words do |t|
        t.timestamps
        t.integer :wordforms_count, limit: 2, default: 0, null: false
        t.string :body
      end

      add_index :words, :body, unique: true
    end
  end

  def down
    if Word.table_exists?
      drop_table :words
    end
  end
end
