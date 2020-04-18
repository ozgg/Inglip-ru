# frozen_string_literal: true

# Create entry and tables for Inglip component
class CreateWordsComponent < ActiveRecord::Migration[6.0]
  def up
    BiovisionComponent.create(slug: Biovision::Components::WordsComponent.slug)
    create_lexeme_types unless LexemeType.table_exists?
    create_lexemes unless Lexeme.table_exists?
    create_words unless Word.table_exists?
    create_wordforms unless Wordform.table_exists?
    create_lexeme_links unless LexemeLink.table_exists?
  end

  def down
    drop_table :lexeme_links if LexemeLink.table_exists?
    drop_table :wordforms if Wordform.table_exists?
    drop_table :words if Word.table_exists?
    drop_table :lexemes if Lexeme.table_exists?
    drop_table :lexeme_types if LexemeType.table_exists?
    BiovisionComponent[Biovision::Components::WordsComponent.slug]&.destroy
  end

  private

  def create_lexeme_types
    create_table :lexeme_types, comment: 'Lexeme types' do |t|
      t.string :slug, null: false
      t.string :name, null: false
      t.integer :lexemes_count, default: 0, null: false
    end

    seed_lexeme_types
  end

  def seed_lexeme_types
    collection = {
      noun: 'Имя существительное',
      adjective: 'Имя прилагательное',
      imperfective_verb: 'Глагол несовершенного вида',
      perfective_verb: 'Глагол совершенного вида',
      participle: 'Причастие',
      gerund: 'Деепричастие',
      preposition: 'Предлог',
      numeral: 'Имя числительное',
      adverb: 'Наречие',
      conjunction: 'Союз',
      predicative: 'Предикатив',
      interjection: 'Междометие',
      pronoun: 'Местоимение',
      particle: 'Частица',
      proper_name: 'Имя собственное'
    }

    collection.each do |slug, name|
      LexemeType.create!(slug: slug, name: name)
    end
  end

  def create_lexemes
    create_table :lexemes, comment: 'Lexemes' do |t|
      t.references :lexeme_type, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.timestamps
      t.integer :wordforms_count, limit: 2, default: 0, null: false
      t.string :context, default: '', null: false
      t.string :body, null: false
      t.jsonb :data, default: {}, null: false
    end

    add_index :lexemes, %i[body lexeme_type_id context], unique: true
    add_index :lexemes, :data, using: :gin
  end

  def create_words
    create_table :words, comment: 'Words' do |t|
      t.integer :wordforms_count, limit: 2, default: 0, null: false
      t.timestamps
      t.string :body
    end

    add_index :words, :body, unique: true
  end

  def create_wordforms
    create_table :wordforms, comment: 'Wordforms' do |t|
      t.references :word, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :lexeme, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.timestamps
      t.integer :flags
    end
  end

  def create_lexeme_links
    create_table :lexeme_links, comment: 'Semantic links between lexemes' do |t|
      t.references :lexeme, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.integer :other_lexeme_id, index: true, null: false
      t.timestamps
      t.jsonb :data, default: {}, null: false
    end

    add_foreign_key :lexeme_links, :lexemes, column: :other_lexeme_id, on_update: :cascade, on_delete: :cascade
  end
end
