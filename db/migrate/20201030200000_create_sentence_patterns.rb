# frozen_string_literal: true

# Create table for sentence patterns
class CreateSentencePatterns < ActiveRecord::Migration[6.0]
  def change
    create_table :sentence_patterns, comment: 'Sentence patterns' do |t|
      t.references :corpus, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.integer :weight, default: 0, null: false
      t.string :sample, default: '', null: false
      t.string :pattern, null: false
    end
  end
end
