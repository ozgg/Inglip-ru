class CreateDreams < ActiveRecord::Migration
  def change
    create_table :dreams do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :dreams, :name
  end
end
