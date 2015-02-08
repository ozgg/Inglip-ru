class CreatePerfectVerbs < ActiveRecord::Migration
  def change
    create_table :perfect_verbs do |t|
      t.boolean :approved, null: false, default: false
      t.references :user, index: true
      t.boolean :has_reflexive, null: false, default: true
      t.boolean :has_reciprocal, null: false, default: false
      t.boolean :has_neuter, null: false, default: false
      t.integer :valency, null: false, default: 3
      t.string :infinitive, null: false
      t.string :imperative
      t.string :gerund
      t.string :passive_masculine
      t.string :passive_feminine
      t.string :passive_neuter
      t.string :passive_plural
      t.string :past_masculine
      t.string :past_feminine
      t.string :past_neuter
      t.string :past_plural
      t.string :future_first
      t.string :future_second
      t.string :future_third
      t.string :future_first_plural
      t.string :future_second_plural
      t.string :future_third_plural

      t.timestamps
    end

    add_index :perfect_verbs, :infinitive, unique: true
    add_index :perfect_verbs, :approved
  end
end
