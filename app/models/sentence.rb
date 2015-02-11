class Sentence
  attr_accessor :use_complement, :use_preposition, :intonation

  def initialize(generator)
    @generator = generator
    seed
  end

  def to_s
    string    = build
    string[0] = string[0].mb_chars.capitalize.to_s
    string + final_mark
  end

  def seed
    @use_complement  = @generator.rand(100) > 50
    @use_preposition = @generator.rand(100) > 50
    @intonation      = :assertion
    if @generator.rand(100) > 75
      @intonation = [:exclamation, :question, :deep][rand(3)]
    end
  end

  def add_member(member)
    @members ||= []
    @members << member
  end

  def build
    (@members || []).join ' '
  end

  def generate
    used_subject   = subject
    used_predicate = predicate
    used_predicate.agree_with used_subject
    add_member used_subject
    add_member used_predicate
    if @use_complement
      complement = subject
      if @use_preposition
        preposition = random_preposition
        add_member preposition.name
        complement.agree_with_preposition preposition
      elsif used_predicate.passive?
        complement.main_case = [:dative, :instrumental][rand(2)]
      else
        complement.main_case = [:accusative, :dative, :instrumental][rand(3)]
      end
      add_member complement
    end
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

  def random_perfect_verb
    offset = @generator.rand(PerfectVerb.count)
    PerfectVerb.offset(offset).first
  end

  def random_adjective
    offset = @generator.rand(Adjective.count)
    Adjective.offset(offset).first
  end

  protected

  def random_case
    [:nominative, :genitive, :dative, :accusative, :instrumental][@generator.rand(5)]
  end

  def random_tense
    [:past, :present, :future][@generator.rand(3)]
  end

  def random_gender
    [:masculine, :feminine, :neuter][@generator.rand(3)]
  end

  def random_number
    @generator.rand(100) > 50 ? :single : :plural
  end

  def random_person
    [:first, :second, :third][@generator.rand(3)]
  end

  def final_mark
    case @intonation
      when :exclamation
        '!'
      when :question
        '?'
      when :deep
        '...'
      else
        '.'
    end
  end
end