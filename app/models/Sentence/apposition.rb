class Sentence::Apposition < Sentence
  attr_accessor :adjective, :gender, :number, :grammatical_case

  QUALITATIVE = 1

  def to_s
    prepare
    build
  end

  def seed
    @adjective = random_adjective
    @gender = random_gender
    @number = random_number
    @grammatical_case = random_case
    flag! :apposition, QUALITATIVE, probability?(10)
  end

  def use_qualitative?
    flag? :apposition, QUALITATIVE
  end

  def agree_with(subject)
    @number = subject.number.to_sym
    @gender = subject.gender.to_sym
    @grammatical_case = subject.agreement_case
  end

  def prepare
    word = @adjective.decline(@gender, @number, @grammatical_case)
    if use_qualitative? && @adjective.qualitative?
      qualitative = random_qualitative
      word = (qualitative.partial + '-' + word) if qualitative
    end
    add_member word
  end

  def random_qualitative
    offset = @generator.rand(Adjective.where(qualitative: true).count)
    Adjective.where(qualitative: true).offset(offset).first
  end
end