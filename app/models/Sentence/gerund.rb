class Sentence::Gerund < Sentence
  NEGATION   = 1
  PAST_TENSE = 2
  PASSIVE    = 4
  PERFECT    = 8
  ADVERB     = 16
  SUBJECT    = 32

  def seed
    @flags[:gerund] = @generator.rand 0xffffffff
    @verb = use_perfect? ? random_perfect_verb : random_verb
  end

  def to_s
    prepare
    build
  end

  def prepare
    add_member random_adverb.body if flag? :gerund, ADVERB
    add_member 'не' if flag? :gerund, NEGATION
    add_member main_member
    add_subject if flag? :gerund, SUBJECT
  end

  def use_perfect?
    flag? :gerund, PERFECT
  end

  def use_passive?
    flag? :gerund, PASSIVE
  end

  def main_member
    word = flag?(:gerund, PAST_TENSE) ? @verb.gerund_past : @verb.gerund
    if use_passive? && @verb.passive_addable?
      word += word[-1, 1].in?(%w(а и у о я)) ? 'сь' : 'шись'
    end
    word
  end

  def add_subject
    used_subject = subject
    cases = [:instrumental]
    cases += [:accusative, :dative] unless use_passive?
    used_subject.main_case = random_case(cases)
    add_member used_subject
  end
end