class Sentence
  include WordSpawner

  attr_accessor :intonation

  FLAG_COMPLEMENT = 1
  FLAG_PREPOSITION = 2

  def initialize(generator)
    @generator = generator
    @flags = @generator.rand 0xFFFFFF
    seed
  end

  def to_s
    string    = build
    string[0] = string[0].mb_chars.capitalize.to_s
    string + final_mark
  end

  def seed
    set_flag FLAG_COMPLEMENT,  @generator.rand(100) > 50
    set_flag FLAG_PREPOSITION, @generator.rand(100) > 50
    @intonation      = :assertion
    if @generator.rand(100) > 75
      @intonation = [:exclamation, :question, :deep][@generator.rand(3)]
    end
  end

  def use_complement?
    has_flag? FLAG_COMPLEMENT
  end

  def use_preposition?
    has_flag? FLAG_PREPOSITION
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
    add_complement used_predicate if use_complement?
  end

  def add_complement(used_predicate)
    complement    = subject
    allowed_cases = used_predicate.passive? ? [:dative, :instrumental, :locative] : []
    if use_preposition?
      preposition = random_preposition allowed_cases
      add_member preposition.name
      complement.agree_with_preposition preposition
    elsif used_predicate.passive?
      complement.main_case = [:dative, :instrumental][@generator.rand(2)]
    else
      complement.main_case = [:accusative, :dative, :instrumental][@generator.rand(3)]
    end
    add_member complement
  end

  def subject
    Sentence::Subject.new @generator
  end

  def predicate
    Sentence::Predicate.new @generator
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

  def has_flag?(flag)
    @flags & flag === flag
  end

  def set_flag(flag, value)
    if value
      @flags = @flags | flag
    else
      @flags = @flags & ~flag
    end
  end
end