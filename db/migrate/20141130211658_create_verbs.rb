class CreateVerbs < ActiveRecord::Migration
  def change
    create_table :verbs do |t|
      t.references :user, index: true
      t.boolean :has_reflexive, null: false, default: true
      t.boolean :has_reciprocal, null: false, default: false
      t.boolean :has_neuter, null: false, default: false
      t.integer :valency, null: false, default: 3
      t.string :infinitive, null: false
      t.string :present_first
      t.string :present_plural_first
      t.string :present_second
      t.string :present_plural_second
      t.string :present_third
      t.string :present_plural_third
      t.string :past_first
      t.string :past_second
      t.string :past_third
      t.string :past_plural
      t.string :past_perfect_first
      t.string :past_perfect_second
      t.string :past_perfect_third
      t.string :past_perfect_plural
      t.string :future_perfect_first
      t.string :future_perfect_second
      t.string :future_perfect_third
      t.string :imperative
      t.string :imperative_perfect

      t.timestamps
    end

    add_index :verbs, :infinitive, unique: true
  end
end
