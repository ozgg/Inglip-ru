class Sentence::Apposition < Sentence
  attr_accessor :adjective, :gender, :number, :grammatical_case

  def to_s
    prepare
    build
  end

  def seed
    @adjective = random_adjective
    @gender = random_gender
    @number = random_number
    @grammatical_case = random_case
  end

  def agree_with(subject)
    @number = subject.number.to_sym
    @gender = subject.gender.to_sym
    @grammatical_case = subject.agreement_case
  end

  def prepare
    add_member @adjective.decline(@gender, @number, @grammatical_case)
  end
end