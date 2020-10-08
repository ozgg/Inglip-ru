# frozen_string_literal: true

# Create tables for text corpora
class CreateCorporaComponent < ActiveRecord::Migration[6.0]
  def up
    BiovisionComponent.create(slug: Biovision::Components::CorporaComponent.slug)
    create_corpora unless Corpus.table_exists?
    create_corpus_texts unless CorpusText.table_exists?
    create_corpus_text_lexemes unless CorpusTextLexeme.table_exists?
    create_corpus_text_words unless CorpusTextWord.table_exists?
    create_pending_words unless PendingWord.table_exists?
    create_corpus_text_pending_words unless CorpusTextPendingWord.table_exists?
  end

  def down
    drop_table :corpus_text_pending_words if CorpusTextPendingWord.table_exists?
    drop_table :pending_words if PendingWord.table_exists?
    drop_table :corpus_text_words if CorpusTextWord.table_exists?
    drop_table :corpus_text_lexemes if CorpusTextLexeme.table_exists?
    drop_table :corpus_texts if CorpusText.table_exists?
    drop_table :corpora if Corpus.table_exists?
    BiovisionComponent[Biovision::Components::CorporaComponent.slug]&.destroy
  end

  private

  def create_corpora
    create_table :corpora, comment: 'Text corpora' do |t|
      t.uuid :uuid, null: false
      t.references :user, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.timestamps
      t.integer :corpus_texts_count, default: 0, null: false
      t.string :name, null: false
      t.jsonb :data, default: {}, null: false
    end

    add_index :corpora, :uuid, unique: true
    add_index :corpora, :data, using: :gin
  end

  def create_corpus_texts
    create_table :corpus_texts, comment: 'Texts in corpora' do |t|
      t.uuid :uuid, null: false
      t.references :corpus, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.timestamps
      t.boolean :processed, default: false, null: false
      t.integer :lexeme_count, default: 0, null: false
      t.integer :word_count, default: 0, null: false
      t.integer :pending_word_count, default: 0, null: false
      t.string :checksum, index: true
      t.text :body, null: false
      t.jsonb :data, default: {}, null: false
    end

    add_index :corpus_texts, :uuid, unique: true
    add_index :corpus_texts, :data, using: :gin
    execute %(
      create or replace function corpus_texts_tsvector(body text)
        returns tsvector as $$
          begin
            return (
              setweight(to_tsvector('russian', body), 'A')
            );
          end
        $$ language 'plpgsql' immutable;
    )
    execute 'create index corpus_texts_search_idx on corpus_texts using gin(corpus_texts_tsvector(body));'
  end

  def create_corpus_text_lexemes
    create_table :corpus_text_lexemes, comment: 'Lexemes in corpus texts' do |t|
      t.references :corpus_text, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :lexeme, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.integer :weight, default: 0, null: false
    end
  end

  def create_corpus_text_words
    create_table :corpus_text_words, comment: 'Words in corpus texts' do |t|
      t.references :corpus_text, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :word, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.integer :weight, default: 0, null: false
    end
  end

  def create_pending_words
    create_table :pending_words, comment: 'Pending words' do |t|
      t.references :word, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.integer :weight, default: 0, null: false
      t.string :body, null: false
    end

    add_index :pending_words, :body, unique: true
  end

  def create_corpus_text_pending_words
    create_table :corpus_text_pending_words, comment: 'Pending words in corpus texts' do |t|
      t.references :corpus_text, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :pending_word, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.integer :weight, default: 0, null: false
    end
  end
end
