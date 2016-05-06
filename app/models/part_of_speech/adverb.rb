class PartOfSpeech::Adverb < PartOfSpeech
  # Сравнительное наречие?
  def qualitative?
    @lexeme.data['type'] == 'qualitative'
  end

  # Количественное наречие?
  def cardinal?
    @lexeme.data['type'] == 'cardinal'
  end

  # Сравнительная степень?
  def comparative?
    @lexeme.data['comparative']
  end

  # Превосходная степень?
  def superlative?
    @lexeme.data['superlative']
  end
end
