class Speech
  def claim
    preposition = random_preposition
    noun = random_noun

    preposition.name + ' ' + noun.decline(preposition.cases.shuffle.first)
  end

  def random_preposition
    offset = Time.now.getutc.to_i % (Preposition.count)
    Preposition.offset(offset).first
  end

  def random_noun
    offset = Time.now.getutc.to_i % (Noun.count)
    Noun.offset(offset).first
  end
end