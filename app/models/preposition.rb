class Preposition < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  def self.for_cases(cases)
    if cases.any?
      allow = [:genitive, :dative, :accusative, :instrumental, :prepositional, :locative]
      parts = []
      cases.each do |c|
        parts << "#{c} = true" if allow.include? c
      end
      parts.any? ? self.where(parts.join ' or ') : self
    else
      self
    end
  end

  def cases
    result = []
    result << :genitive if genitive?
    result << :dative if dative?
    result << :instrumental if instrumental?
    result << :prepositional if prepositional?
    result << :accusative if accusative?
    result << :locative if locative?

    result
  end
end
