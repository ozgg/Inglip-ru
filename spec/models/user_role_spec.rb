require 'rails_helper'

RSpec.describe UserRole, type: :model do
  describe 'validation' do
    it 'passes with valid attributes' do
      pair = build :user_role
      expect(pair).to be_valid
    end

    it 'fails without user' do
      pair = build :user_role, user: nil
      expect(pair).not_to be_valid
    end

    it 'fails with non-unique pair' do
      existing = create :user_role
      pair     = build :user_role, user: existing.user, role: existing.role
      expect(pair).not_to be_valid
    end
  end
end
