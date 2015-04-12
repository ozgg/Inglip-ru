class Sentence::Predicate < Sentence
  attr_accessor :number, :gender, :person, :tense

  FLAG_PERFECT = 0
  FLAG_NEGATION = 1
  FLAG_PASSIVE = 2
  FLAG_ADVERB = 4

  def to_s
    prepare
    build
  end

  def seed
    set_flag FLAG_PERFECT, @generator.rand(100) > 50
    @main_member = use_perfect? ? random_perfect_verb : random_verb
    @tense = random_tense
    @person = random_person
    set_flag FLAG_NEGATION, @generator.rand(100) > 50
    set_flag FLAG_PASSIVE, @generator.rand(100) > 80
    set_flag FLAG_ADVERB, @generator.rand(100) > 60
  end

  def use_perfect?
    has_flag? FLAG_PERFECT
  end

  def use_negation?
    has_flag? FLAG_NEGATION
  end

  def use_passive?
    has_flag? FLAG_PASSIVE
  end

  def use_adverb?
    has_flag? FLAG_ADVERB
  end

  def passive?
    use_passive? || (@main_member.is_a?(PerfectVerb) && @tense === :present)
  end

  def prepare
    add_member random_adverb.body if use_adverb?
    add_member 'не' if use_negation?
    main_member = @main_member.decline(@tense, @person, @gender, @number)
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
end