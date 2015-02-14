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
    sentence
  end

  def sentence
    sentence = Sentence.new(@generator)
    sentence.generate
    sentence.to_s
  end

  def passage
    sentences = []
    (@generator.rand(9) + 2).times { sentences << sentence }
    sentences.join ' '
  end

  def post
    parts = [sentence]
    (@generator.rand(6) + 2).times { parts << passage}
    parts.join "\n\n"
  end
end