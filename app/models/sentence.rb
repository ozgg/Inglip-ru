class Sentence
  def initialize(generator)
    @generator = generator
  end

  def to_s
    build
  end

  def add_member(member)
    @members ||= []
    @members << member
  end

  def build
    (@members || []).join ' '
  end

  def subject
    Sentence::Subject.new @generator
  end

  def predicate
    Sentence::Predicate.new @generator
  end

  def random_preposition
    offset = @generator.rand(Preposition.count)
    Preposition.offset(offset).first
  end

  def random_noun
    offset = @generator.rand(Noun.count)
    Noun.offset(offset).first
  end

  def random_verb
    offset = @generator.rand(Verb.count)
    Verb.offset(offset).first
  end

  protected

  def random_case
    [:nominative, :genitive, :dative, :accusative, :instrumental].shuffle.first
  end

  def random_tense
    [:past, :present, :future].shuffle.first
  end

  def random_gender
    [:masculine, :feminine, :neuter].shuffle.first
  end

  def random_number
    @generator.rand(100) > 50 ? :single : :plural
  end

  def random_person
    [:first, :second, :third].shuffle.first
  end
end