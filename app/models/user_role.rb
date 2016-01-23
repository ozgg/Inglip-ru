class UserRole < ActiveRecord::Base
  belongs_to :user
  enum role: [:administrator]
end
