class Sentence::Subject < Sentence
  attr_accessor :use_dependence, :main_case, :number, :use_apposition

  def to_s
    prepare
    build
  end

  def seed
    @main_member = random_noun
    @use_dependence = (@generator.rand(100) > 40)
    @use_apposition = (@generator.rand(100) > 30)
    @main_case = :nominative
    @number = @main_member.number || random_number
  end

  def prepare
    if @use_apposition
      apposition = Apposition.new(@generator)
      apposition.agree_with self
      add_member apposition.to_s
    end

    add_member @main_member.decline(@main_case, @number)

    if @use_dependence
      dependent = Subject.new(@generator)
      dependent.seed
      dependent.use_dependence = false
      dependent.main_case = :genitive
      add_member dependent.to_s
    end
  end

  def agreement_case
    if @main_case.to_sym === :locative
      :prepositional
    elsif @main_case.to_sym === :accusative
      (@main_member.animated? || @main_member.feminine?) ? :accusative : :nominative
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