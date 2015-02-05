class Verb < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :infinitive
  validates_uniqueness_of :infinitive
end
