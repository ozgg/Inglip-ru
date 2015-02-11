class Sentence::Predicate < Sentence
  attr_accessor :number, :gender, :person, :tense, :use_negation, :use_perfect, :use_passive

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
    @use_passive = @generator.rand(100) > 80
  end

  def passive?
    @use_passive || (@main_member.is_a?(PerfectVerb) && @tense === :present)
  end

  def prepare
    add_member 'не' if @use_negation
    main_member = @main_member.decline(@tense, @person, @gender, @number)
    if @use_passive && @main_member.is_a?(Verb) && @main_member.passive_addable?
      main_member += main_member[-1, 1].in?(%w(а и у о я)) ? 'сь' : 'ся'
    end

    add_member main_member
  end

  def agree_with(subject)
    @person = :third
    @number = subject.number.to_sym
    @gender = subject.gender.to_sym
  end
end