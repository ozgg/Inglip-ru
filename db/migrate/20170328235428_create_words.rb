class CreateWords < ActiveRecord::Migration[5.0]
  def change
    create_table :words do |t|
      t.timestamps
      t.string :body, null: false, index: true
    end
  end
end
