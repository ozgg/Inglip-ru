class Sentence::Predicate < Sentence
  attr_accessor :number, :gender, :person, :tense

  PERFECT  = 0b00001
  NEGATION = 0b00010
  PASSIVE  = 0b00100
  ADVERB   = 0b01000
  GERUND   = 0b10000

  def to_s
    prepare
    build
  end

  def seed
    @flags[:predicate] = @generator.rand 0xffffffff
    predicate_flag! PERFECT, probability(50)
    @main_member = use_perfect? ? random_perfect_verb : random_verb
    @tense = random_tense
    @person = random_person
    predicate_flag! NEGATION, probability(50)
    predicate_flag! PASSIVE, probability(20)
    predicate_flag! ADVERB, probability(40)
  end

  def predicate_flag?(flag)
    flag? :predicate, flag
  end

  def predicate_flag!(flag, value = true)
    flag! :predicate, flag, value
  end

  def use_perfect?
    predicate_flag? PERFECT
  end

  def use_negation?
    predicate_flag? NEGATION
  end

  def use_passive?
    predicate_flag? PASSIVE
  end

  def use_adverb?
    predicate_flag? ADVERB
  end

  def passive?
    use_passive? || (@main_member.is_a?(PerfectVerb) && @tense === :present)
  end

  def prepare
    # prepend_gerund if predicate_flag? GERUND
    add_member random_adverb.body if use_adverb?
    add_member 'не' if use_negation?
    if use_imperative?
      main_member = @main_member.imperative
      main_member = "[#{@main_member.infinitive}]" if main_member.blank?
    else
      main_member = @main_member.decline(@tense, @person, @gender, @number)
    end
    if use_passive? && @main_member.is_a?(Verb) && @main_member.passive_addable?
      main_member += main_member[-1, 1].in?(%w(а и у о я)) ? 'сь' : 'ся'
    end

    add_member main_member
  end

  def agree_with(subject)
    @person = :third
    @number = subject.number.to_sym
    @gender = subject.gender.to_sym
  end

  protected

  def prepend_gerund
    add_member ','
    add_member random_adverb.body if @generator.rand(100) > 50
    add_member random_verb.gerund
    if @generator.rand(100) > 50
      add_member random_noun.decline(random_case)
    end
    add_member ','
  end
end