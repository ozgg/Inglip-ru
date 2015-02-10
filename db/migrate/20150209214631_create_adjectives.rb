class CreateAdjectives < ActiveRecord::Migration
  def change
    create_table :adjectives do |t|
      t.boolean :approved, null: false, default: false
      t.references :user, index: true
      t.boolean :qualitative, null: false, default: false
      t.boolean :possessive, null: false, default: false
      t.boolean :participle, null: false, default: false
      t.boolean :superlative, null: false, default: false
      t.string :nominative_masculine, null: false
      t.string :genitive_masculine, null: false
      t.string :dative_masculine, null: false
      t.string :accusative_masculine, null: false
      t.string :instrumental_masculine, null: false
      t.string :prepositional_masculine, null: false
      t.string :nominative_feminine, null: false
      t.string :genitive_feminine, null: false
      t.string :dative_feminine, null: false
      t.string :accusative_feminine, null: false
      t.string :instrumental_feminine, null: false
      t.string :prepositional_feminine, null: false
      t.string :nominative_neuter, null: false
      t.string :genitive_neuter, null: false
      t.string :dative_neuter, null: false
      t.string :accusative_neuter, null: false
      t.string :instrumental_neuter, null: false
      t.string :prepositional_neuter, null: false
      t.string :nominative_plural, null: false
      t.string :genitive_plural, null: false
      t.string :dative_plural, null: false
      t.string :accusative_plural, null: false
      t.string :instrumental_plural, null: false
      t.string :prepositional_plural, null: false
      t.string :partial
      t.string :comparative

      t.timestamps
    end

    add_index :adjectives, :nominative_masculine, unique: true
    add_index :adjectives, :approved
  end
end
