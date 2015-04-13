module WordSpawner
  extend ActiveSupport::Concern

  def apposition
    Sentence::Apposition.new @generator
  end

  def gerund
    Sentence::Gerund.new @generator
  end

  def subject
    Sentence::Subject.new @generator
  end

  def predicate
    Sentence::Predicate.new @generator
  end

  def random_preposition(allow_cases = [])
    sample = Preposition.for_cases allow_cases
    offset = @generator.rand(sample.count)
    sample.offset(offset).first
  end

  def random_noun
    offset = @generator.rand(Noun.count)
    Noun.offset(offset).first
  end

  def random_verb
    offset = @generator.rand(Verb.count)
    Verb.offset(offset).first
  end

  def random_perfect_verb
    offset = @generator.rand(PerfectVerb.count)
    PerfectVerb.offset(offset).first
  end

  def random_adjective
    offset = @generator.rand(Adjective.count)
    Adjective.offset(offset).first
  end

  def random_qualitative
    offset = @generator.rand(Adjective.where(qualitative: true).count)
    Adjective.where(qualitative: true).offset(offset).first
  end

  def random_adverb
    offset = @generator.rand(Adverb.count)
    Adverb.offset(offset).first
  end
end