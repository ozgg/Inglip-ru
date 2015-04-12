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
    @main_case   = :nominative
    @number      = @main_member.number || random_number
    seed_flags
  end

  def prepare
    add_apposition if use_apposition?
    add_member @main_member.decline(@main_case, @number)
    add_dependence if use_dependence?
  end

  def use_dependence?
    flag? :noun, DEPENDENCE
  end

  def use_apposition?
    flag? :noun, APPOSITION
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

  protected

  def seed_flags
    flag! :noun, DEPENDENCE, probability?(60)
    flag! :noun, APPOSITION, probability?(70)
  end

  def add_apposition
    used_apposition = apposition
    used_apposition.agree_with self
    add_member used_apposition.to_s
  end

  def add_dependence
    dependent = subject
    dependent.flag! :noun, DEPENDENCE, false
    dependent.main_case = :genitive
    add_member dependent.to_s
  end
end