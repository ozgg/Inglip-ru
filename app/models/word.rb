class Word < ActiveRecord::Base
  has_many :wordforms
  has_many :lexemes, through: :wordforms

  validates_presence_of :body
  validates_uniqueness_of :body, scope: [:stress]

  # @param [String] word
  def self.stressed(word)
    analyzer = StressAnalyzer.new word
    find_or_create_by! body: analyzer.body, stress: analyzer.stress
  end
end
