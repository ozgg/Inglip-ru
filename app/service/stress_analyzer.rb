class StressAnalyzer
  attr_reader :body, :stress

  STRESS_MARK = /['"]/

  # @param [String] text
  def initialize(text)
    @body   = ''
    @stress = ''
    text.to_s.each_char.with_index do |letter, index|
      if vowel? letter
        @stress << stress_type(letter, text[index + 1])
      end
      @body << current_letter(letter, text[index + 1])
    end
    @stress = nil if @stress.blank?
  end

  private

  # @param [String] letter
  def vowel?(letter)
    letter =~ /[аеёиоуыэюяАЕЁИОУЫЭЮЯ]/
  end

  # Get stress type for current letter using next symbol
  #
  # 1 is stressed letter, 0 is unstressed letter
  # ё should be always stressed
  #
  # @param [String] letter
  # @param [String] next_symbol
  def stress_type(letter, next_symbol)
    (letter =~ /[ёЁ]/ || next_symbol.to_s =~ STRESS_MARK) ? '1' : '0'
  end

  # Get current letter using current letter and next symbol
  #
  # When next symbol is double quote, current letter is ё
  #
  # @param [String] letter
  # @param [String] next_symbol
  def current_letter(letter, next_symbol)
    if letter =~ STRESS_MARK || letter == '*'
      ''
    else
      next_symbol.to_s == '"' ? 'ё' : letter
    end
  end
end
