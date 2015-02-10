class Preposition < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

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
