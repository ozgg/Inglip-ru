require 'rails_helper'

RSpec.describe Wordform, type: :model do
  describe 'validation' do
    it 'passes with valid attributes' do
      wordform = build :wordform
      expect(wordform).to be_valid
    end

    it 'fails without word' do
      wordform = build :wordform, word_id: nil
      expect(wordform).not_to be_valid
    end

    it 'fails without lexeme' do
      wordform = build :wordform, lexeme_id: nil
      expect(wordform).not_to be_valid
    end

    it 'fails without indicator' do
      wordform = build :wordform, indicator: nil
      expect(wordform).not_to be_valid
    end

    it 'fails without non-unique triplet' do
      existing = create :wordform
      wordform = build :wordform, word: existing.word, lexeme: existing.lexeme, indicator: existing.indicator
      expect(wordform).not_to be_valid
    end
  end
end
