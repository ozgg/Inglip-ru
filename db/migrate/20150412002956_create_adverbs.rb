class CreateAdverbs < ActiveRecord::Migration
  def change
    create_table :adverbs do |t|
      t.integer :family, null: false
      t.boolean :is_comparative, null: false, default: false
      t.string :body, null: false
      t.string :comparative_degree

      t.timestamps
    end

    add_index :adverbs, :body
  end
end
