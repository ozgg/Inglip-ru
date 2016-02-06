require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it 'passes with valid attributes' do
      user = build :user
      expect(user).to be_valid
    end

    it 'fails without login' do
      user = build :user, login: ' '
      expect(user).not_to be_valid
    end

    it 'fails with non-unique login' do
      existing = create :user
      user     = build :user, login: existing.login
      expect(user).not_to be_valid
    end
  end
end
