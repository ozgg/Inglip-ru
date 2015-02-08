class Speech

  def initialize(seed = nil)
    @generator = Random.new(seed || Random.new_seed)
  end

  def seed
    @generator.seed
  end

  def claim
    sentence = Sentence.new @generator
    noun = sentence.random_noun
    verb = sentence.random_verb

    if @generator.rand(10) > 5
      verb.imperative + ' ' + noun.instrumental
    else
      noun.nominative + ' ' + verb.present_third
    end
  end

  def tagline
    sentence = Sentence.new(@generator)
    subject = sentence.subject
    subject.seed
    predicate = sentence.predicate
    predicate.seed
    predicate.agree_with subject
    sentence.add_member subject
    sentence.add_member predicate
    sentence.to_s
  end
end