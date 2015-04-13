class Sentence
  include WordSpawner

  attr_accessor :intonation

  COMPLEMENT  = 0b0001
  PREPOSITION = 0b0010
  IMPERATIVE  = 0b0100
  GERUND      = 0b1000

  def initialize(generator = nil)
    @generator = generator || Random.new(Random.new_seed)
    @flags = {}
    seed
  end

  def to_s
    string    = build
    string[0] = string[0].mb_chars.capitalize.to_s
    string + final_mark
  end

  def seed
    seed_flags
    @intonation      = :assertion
    if probability? 25
      @intonation = [:exclamation, :question, :deep][@generator.rand(3)]
    end
  end

  def seed_flags
    flag! :sentence, COMPLEMENT,  probability?(50)
    flag! :sentence, PREPOSITION, probability?(50)
    flag! :sentence, IMPERATIVE,  probability?(20)
    flag! :sentence, GERUND,      probability?(50)
  end

  def use_complement?
    sentence_flag? COMPLEMENT
  end

  def use_preposition?
    sentence_flag? PREPOSITION
  end

  def use_imperative?
    sentence_flag? IMPERATIVE
  end

  def add_member(member)
    @members ||= []
    @members << member
  end

  def build
    (@members || []).join(' ').gsub(' ,', ',')
  end

  def generate
    add_gerund(false, true) if flag? :sentence, GERUND
    used_subject   = subject
    used_predicate = predicate
    if use_imperative?
      used_predicate.sentence_flag! IMPERATIVE, true
      used_subject.main_case = [:genitive, :dative, :accusative][@generator.rand(3)]
      add_member used_predicate
      add_member used_subject
    else
      used_predicate.agree_with used_subject
      add_member used_subject
      add_member used_predicate
    end
    add_complement used_predicate if use_complement?
    add_gerund(true, false) if probability?(20)
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

  def add_gerund(isolate_left = false, isolate_right = false)
    used_gerund = gerund
    add_member ',' if isolate_left
    add_member used_gerund
    add_member ',' if isolate_right
  end

  def flag?(group, flag)
    @flags.has_key?(group) && (@flags[group] & flag === flag)
  end

  def flag!(group, flag, value = true)
    @flags[group] ||= 0

    if value
      @flags[group] |= flag
    else
      @flags[group] &= ~flag
    end
  end

  def sentence_flag?(flag)
    flag? :sentence, flag
  end

  def sentence_flag!(flag, value = true)
    flag! :sentence, flag, value
  end

  protected

  def probability?(percent)
    weight = 100 - (percent.to_i % 100)
    @generator.rand(100) > weight
  end

  def random_case(cases = [:nominative, :genitive, :dative, :accusative, :instrumental])
    cases[@generator.rand(cases.size)]
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