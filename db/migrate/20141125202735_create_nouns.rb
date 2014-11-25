class CreateNouns < ActiveRecord::Migration
  def change
    create_table :nouns do |t|
      t.references :user, index: true
      t.boolean :approved, null: false, default: false
      t.integer :grammatical_gender, null: false
      t.integer :grammatical_number, null: false
      t.boolean :animated, null: false
      t.boolean :has_locative, null: false, default: false
      t.boolean :has_partitive, null: false, default: false
      t.boolean :common_gender, null: false, default: false
      t.boolean :mutual_gender, null: false, default: false
      t.string :nominative, null: false
      t.string :genitive, null: false
      t.string :dative, null: false
      t.string :instrumental, null: false
      t.string :prepositional, null: false
      t.string :plural_nominative
      t.string :plural_genitive
      t.string :plural_dative
      t.string :plural_instrumental
      t.string :plural_prepositional

      t.timestamps
    end

    add_index :nouns, :nominative, unique: true
    add_index :nouns, :approved

    Noun.create!(
        {
            approved: true, grammatical_gender: :masculine, grammatical_number: :both, animated: true,
            nominative: 'Инглип', genitive: 'Инглипа', dative: 'Инглипу', instrumental: 'Инглипом', prepositional: 'Инглипе',
            plural_nominative: 'Инглипы', plural_genitive: 'Инглипов', plural_dative: 'Инглипам',
            plural_instrumental: 'Инглипами', plural_prepositional: 'Инглипах',
        }
    )
  end
end
