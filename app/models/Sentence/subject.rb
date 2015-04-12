class Sentence::Subject < Sentence
  attr_accessor :main_case, :number

  DEPENDENCE = 1
  APPOSITION = 2

  def to_s
    prepare
    build
  end

  def seed
    @main_member = random_noun
    noun_flag! DEPENDENCE, probability(60)
    noun_flag! APPOSITION, probability(70)
    @main_case = :nominative
    @number = @main_member.number || random_number
  end

  def prepare
    if use_apposition?
      apposition = Apposition.new(@generator)
      apposition.agree_with self
      add_member apposition.to_s
    end

    add_member @main_member.decline(@main_case, @number)

    if use_dependence?
      dependent = Subject.new(@generator)
      dependent.seed
      dependent.noun_flag! DEPENDENCE, false
      dependent.main_case = :genitive
      add_member dependent.to_s
    end
  end

  def noun_flag?(flag)
    flag? :noun, flag
  end

  def noun_flag!(flag, value = true)
    flag! :noun, flag, value
  end

  def use_dependence?
    noun_flag? DEPENDENCE
  end

  def use_apposition?
    noun_flag? APPOSITION
  end

  def agreement_case
    if @main_case.to_sym === :locative
      :prepositional
    elsif @main_case.to_sym === :accusative
      @main_member.animated? ? :accusative : :nominative
    else
      @main_case.to_sym
    end
  end

  def gender
    @main_member.grammatical_gender.to_sym
  end

  def agree_with_preposition(preposition)
    available_cases = preposition.cases
    @main_case = available_cases.any? ? available_cases[@generator.rand(available_cases.size)] : :nominative
  end
end