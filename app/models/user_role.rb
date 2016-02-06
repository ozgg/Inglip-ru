class UserRole < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user_id, :role
  validates_uniqueness_of :role, scope: [:user_id]

  enum role: [:administrator]
end
