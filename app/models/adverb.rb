class Adverb < ActiveRecord::Base
  validates_presence_of :body
  validates_uniqueness_of :body

  enum family: [:conduct, :measure, :time, :place, :reason, :totality]

  def canonical_form
    body
  end
end
