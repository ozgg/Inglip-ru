# frozen_string_literal: true

# Text sample in corpus
# 
# Attributes:
#   body [text]
#   checksum [string]
#   created_at [DateTine]
#   corpus_id [Corpus]
#   data [jsonb]
#   lexeme_count [integer]
#   pending_word_count [integer]
#   processed [boolean]
#   updated_at [DateTime]
#   uuid [uuid]
#   word_count [integer]
class CorpusText < ApplicationRecord
  include Checkable
  include HasUuid
  include Toggleable

  toggleable :processed

  belongs_to :corpus, counter_cache: true
  has_many :corpus_text_lexemes, dependent: :delete_all
  has_many :lexemes, through: :corpus_text_lexemes
  has_many :corpus_text_words, dependent: :delete_all
  has_many :words, through: :corpus_text_words
  has_many :corpus_text_pending_words, dependent: :delete_all
  has_many :pending_words, through: :corpus_text_pending_words

  validates_presence_of :body
  validates_uniqueness_of :checksum, scope: :corpus_id

  before_validation { self.checksum = Digest::MD5.hexdigest(body.to_s) }

  scope :processed, ->(f = 1) { where(processed: f.to_i.positive?) unless f.blank? }
  scope :recent, -> { order('id desc') }
  scope :list_for_administration, -> { recent }

  # @param [Integer] page
  def self.page_for_administration(page = 1)
    list_for_administration.page(page)
  end

  def self.entity_parameters
    %i[body]
  end

  def self.creation_parameters
    %i[corpus_id] + entity_parameters
  end

  def <<(entity)
    case entity.class
    when Word
      add_word(entity)
    when Lexeme
      add_lexeme(entity)
    when PendingWord
      add_pending_word(entity)
    else
      nil
    end
  end

  # @param [Word] entity
  # @param [Integer] quantity
  def add_word(entity, quantity = 1)
    link = corpus_text_words.find_or_initialize_by(word: entity)
    link.quantity += quantity
    link.save
  end

  # @param [Lexeme] entity
  # @param [Integer] quantity
  def add_lexeme(entity, quantity = 1)
    link = corpus_text_lexemes.find_or_initialize_by(lexeme: entity)
    link.quantity += quantity
    link.save
  end

  # @param [PendingWord] entity
  # @param [Integer] quantity
  def add_pending_word(entity, quantity = 1)
    link = corpus_text_pending_words.find_or_initialize_by(pending_word: entity)
    link.quantity += quantity
    link.save
  end
end
