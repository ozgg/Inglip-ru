class Sentence::Subject < Sentence
  attr_accessor :use_dependence, :main_case, :number

  def initialize(generator)
    super
    @main_member = random_noun
  end

  def to_s
    prepare
    build
  end

  def seed
    @use_dependence = (@generator.rand(100) > 40)
    @main_case = random_case
    @number = @main_member.number || random_number
  end

  def prepare
    add_member @main_member.decline(@use_dependence ? :nominative : @main_case, @number)

    if @use_dependence
      dependent = Subject.new(@generator)
      dependent.seed
      dependent.use_dependence = false
      dependent.main_case = :genitive
      add_member dependent.to_s
    end
  end

  def gender
    @main_member.grammatical_gender.to_sym
  end
end