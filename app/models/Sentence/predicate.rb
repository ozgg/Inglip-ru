class Sentence::Predicate < Sentence
  attr_accessor :number, :gender, :person, :tense

  def initialize(generator)
    super
    @main_member = random_verb
  end

  def to_s
    prepare
    build
  end

  def seed
    @tense = random_tense
    @person = random_person
  end

  def prepare
    add_member @main_member.decline(@tense, @person, @gender, @number)
  end

  def agree_with(subject)
    @person = :third
    @number = subject.number.to_sym
    @gender = subject.gender.to_sym
  end
end