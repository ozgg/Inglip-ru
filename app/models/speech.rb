class Speech
  def claim
    noun = random_noun
    verb = random_verb

    noun.nominative + ' ' + verb.present_third + 'ся'
  end

  def random_preposition
    offset = Time.now.getutc.to_i % (Preposition.count)
    Preposition.offset(offset).first
  end

  def random_noun
    offset = Time.now.getutc.to_i % (Noun.count)
    Noun.offset(offset).first
  end

  def random_verb
    offset = Time.now.getutc.to_i % (Verb.count)
    Verb.offset(offset).first
  end

  protected

  def random_case
    [:nominative, :genitive, :dative, :accusative, :instrumental].shuffle.first
  end
end