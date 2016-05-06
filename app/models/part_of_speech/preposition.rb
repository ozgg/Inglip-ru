class PartOfSpeech::Preposition < PartOfSpeech
  # Субъект в родительном падеже?
  def genitive?
    @lexeme.data['genitive']
  end

  # Субъект в дательном падеже?
  def dative?
    @lexeme.data['dative']
  end

  # Субъект в винительном падеже?
  def accusative?
    @lexeme.data['accusative']
  end

  # Субъект в творительном падеже?
  def instrumental?
    @lexeme.data['instrumental']
  end

  # Субъект в предложном падеже?
  def prepositional?
    @lexeme.data['prepositional']
  end

  # Субъект в локативе?
  def locative?
    @lexeme.data['locative']
  end
end
