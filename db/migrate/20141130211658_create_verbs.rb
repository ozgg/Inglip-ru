class CreateVerbs < ActiveRecord::Migration
  def change
    create_table :verbs do |t|
      t.references :user, index: true
      t.boolean :approved, null: false, default: false
      t.boolean :has_reflexive, null: false, default: true
      t.boolean :has_reciprocal, null: false, default: false
      t.boolean :has_neuter, null: false, default: false
      t.integer :valency, null: false, default: 3
      t.string :infinitive, null: false
      t.string :imperative
      t.string :present_first
      t.string :present_second
      t.string :present_third
      t.string :present_first_plural
      t.string :present_second_plural
      t.string :present_third_plural
      t.string :past_masculine
      t.string :past_feminine
      t.string :past_neuter
      t.string :past_plural

      t.timestamps
    end

    add_index :verbs, :infinitive, unique: true

    Verb.create!({
                     approved:              true,
                     has_neuter:            true,
                     valency:               2,
                     infinitive:            'вызывать',
                     imperative:            'вызывай',
                     present_first:         'вызываю',
                     present_first_plural:  'вызываем',
                     present_second:        'вызываешь',
                     present_second_plural: 'вызываете',
                     present_third:         'вызывает',
                     present_third_plural:  'вызывают',
                     past_masculine:        'вызывал',
                     past_feminine:         'вызывала',
                     past_neuter:           'вызывало',
                     past_plural:           'вызывали',
                 })
  end
end
