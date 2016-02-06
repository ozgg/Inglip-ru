require 'rails_helper'

RSpec.describe Word, type: :model do
  describe 'validation' do
    it 'passes with valid attributes' do
      word = build :word
      expect(word).to be_valid
    end

    it 'fails with empty body' do
      word = build :word, body: ' '
      expect(word).not_to be_valid
    end

    it 'fails with non-unique body for same stress' do
      existing = create :word, stress: '10'
      word = build :word, body: existing.body, stress: existing.stress
      expect(word).not_to be_valid
    end
  end
end
