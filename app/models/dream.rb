class Dream < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  def seed
    Digest::MD5.hexdigest(name).to_i(16)
  end
end
