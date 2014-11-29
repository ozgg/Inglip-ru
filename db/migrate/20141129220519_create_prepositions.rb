class CreatePrepositions < ActiveRecord::Migration
  def change
    create_table :prepositions do |t|
      t.string :name, null: false
      t.boolean :genitive, default: false
      t.boolean :dative, default: false
      t.boolean :accusative, default: false
      t.boolean :instrumental, default: false
      t.boolean :prepositional, default: false
      t.boolean :locative, default: false

      t.timestamps
    end

    add_index :prepositions, :name, unique: true

    Preposition.create! name: 'без', genitive: true
    Preposition.create! name: 'до', genitive: true
    Preposition.create! name: 'для', genitive: true
    Preposition.create! name: 'у', genitive: true
    Preposition.create! name: 'ради', genitive: true
    Preposition.create! name: 'к', dative: true
    Preposition.create! name: 'про', accusative: true
    Preposition.create! name: 'через', accusative: true
    Preposition.create! name: 'сквозь', accusative: true
    Preposition.create! name: 'над', instrumental: true
    Preposition.create! name: 'перед', instrumental: true
    Preposition.create! name: 'при', prepositional: true
    Preposition.create! name: 'в', accusative: true, prepositional: true, locative: true
    Preposition.create! name: 'на', accusative: true, prepositional: true, locative: true
    Preposition.create! name: 'о', accusative: true, prepositional: true
    Preposition.create! name: 'между', genitive: true, instrumental: true
    Preposition.create! name: 'за', accusative: true, instrumental: true
    Preposition.create! name: 'под', accusative: true, instrumental: true
    Preposition.create! name: 'по', dative: true, accusative: true, prepositional: true
    Preposition.create! name: 'с', dative: true, accusative: true, instrumental: true
    Preposition.create! name: 'из', genitive: true
    Preposition.create! name: 'из-под', genitive: true
    Preposition.create! name: 'из-за', genitive: true
  end
end
