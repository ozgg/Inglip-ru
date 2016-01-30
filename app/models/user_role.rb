class UserRole < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user_id, :role

  enum role: [:administrator]
end
