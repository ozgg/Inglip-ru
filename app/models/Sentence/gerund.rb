class Sentence::Gerund < Sentence
  NEGATION   = 1
  PAST_TENSE = 2
  PASSIVE    = 4

  def seed
    @flags[:gerund] = @generator.rand 0xffffffff
  end

  def gerund_flag?(flag)
    flag? :gerund, flag
  end

  def gerund_flag!(flag, value = true)
    flag! :gerund, flag, value
  end
end