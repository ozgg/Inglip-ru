class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :login
  validates_uniqueness_of :login
end
