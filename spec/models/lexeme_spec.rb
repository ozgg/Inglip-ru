require 'rails_helper'

RSpec.describe Lexeme, type: :model do
  describe 'validation' do
    it 'passes with valid attributes' do
      lexeme = build :lexeme
      expect(lexeme).to be_valid
    end

    it 'fails without body' do
      lexeme = build :lexeme, body: ' '
      expect(lexeme).not_to be_valid
    end

    it 'fails with non-unique body in context and part' do
      existing = create :lexeme
      lexeme   = build :lexeme, body: existing.body, context: existing.context, part: existing.part
      expect(lexeme).not_to be_valid
    end
  end
end
