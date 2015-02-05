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
      t.string :infinitive_imperative
      t.string :present_first
      t.string :present_plural_first
      t.string :present_second
      t.string :present_plural_second
      t.string :present_third
      t.string :present_plural_third
      t.string :past
      t.string :past_plural
      t.string :past_perfect
      t.string :past_perfect_plural
      t.string :future_perfect_first
      t.string :future_perfect_first_plural
      t.string :future_perfect_second
      t.string :future_perfect_second_plural
      t.string :future_perfect_third
      t.string :future_perfect_third_plural
      t.string :passive
      t.string :imperative
      t.string :imperative_perfect

      t.timestamps
    end

    add_index :verbs, :infinitive, unique: true

    Verb.create!({
      approved: true,
      has_neuter: true,
      valency: 2,
      infinitive: 'вызывать',
      infinitive_imperative: 'вызывть',
      present_first: 'вызываю',
      present_plural_first: 'вызываем',
      present_second: 'вызываешь',
      present_plural_second: 'вызываете',
      present_third: 'вызывает',
      present_plural_third: 'вызывают',
      past: 'вызывал',
      past_plural: 'вызывали',
      past_perfect: 'вызвал',
      past_perfect_plural: 'вызвали',
      future_perfect_first: 'вызову',
      future_perfect_first_plural: 'вызовем',
      future_perfect_second: 'вызовешь',
      future_perfect_second_plural: 'вызовете',
      future_perfect_third: 'вызовет',
      future_perfect_third_plural: 'вызовут',
      passive: 'вызван',
      imperative: 'вызывай',
      imperative_perfect: 'вызови'
    })
  end
end
