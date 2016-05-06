class PartOfSpeech::Conjunction < PartOfSpeech
  # Сочинительный?
  def coordinating?
    @lexeme.data['meaning'] == 'coordinating'
  end

  # Подчинительный?
  def subordinating?
    @lexeme.data['meaning'] == 'subordinating'
  end
end
