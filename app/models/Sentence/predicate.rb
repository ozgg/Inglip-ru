class Sentence::Predicate < Sentence
  attr_accessor :number, :gender, :person, :tense, :use_negation, :use_perfect

  def to_s
    prepare
    build
  end

  def seed
    @use_perfect = @generator.rand(100) > 50
    @main_member = @use_perfect ? random_perfect_verb : random_verb
    @tense = random_tense
    @person = random_person
    @use_negation = @generator.rand(100) > 50
  end

  def prepare
    add_member 'не' if @use_negation
    add_member @main_member.decline(@tense, @person, @gender, @number)
  end

  def agree_with(subject)
    @person = :third
    @number = subject.number.to_sym
    @gender = subject.gender.to_sym
  end
end