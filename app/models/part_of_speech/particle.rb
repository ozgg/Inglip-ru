class PartOfSpeech::Particle < PartOfSpeech
  # Сослагательная частица?
  def subjunctive?
    @lexeme.data['rank'] == 'subjunctive'
  end

  # Отрицательная частица?
  def negative?
    @lexeme.data['rank'] == 'negative'
  end

  # Частица, характеризующая признак?
  def indicating?
    @lexeme.data['rank'] == 'indicating'
  end

  # Модальная частица?
  def modal?
    @lexeme.data['rank'] == 'modal'
  end

  # Положение относительно слова
  #
  # @return [String] 'before'|'after'|'both'
  def position
    @lexeme.data['position']
  end
end
