class LexemeHandler
  attr_reader :lexeme

  # @param [Lexeme] lexeme
  def initialize(lexeme)
    self.lexeme = lexeme unless lexeme.nil?
    @wordforms  = {}
  end

  # @param [String|Lexeme] entity
  def self.handler(entity)
    if entity.is_a?(Lexeme)
      slug   = entity.lexeme_type.slug.to_sym
      lexeme = entity
    else
      slug   = entity.to_sym
      lexeme = nil
    end

    case slug
    when :noun
      LexemeHandler::Noun.new(lexeme)
    else
      nil
    end
  end

  # @return [String]
  def self.allowed_lexeme_type
    ''
  end

  # @return [Hash]
  def self.lexeme_flags
    {}
  end

  # @return [Hash]
  def self.wordform_flags
    {
      infinitive:         0b0000_0000_0000_0000_0000_0000_0000_0001,
      gender_masculine:   0b0000_0000_0000_0000_0000_0000_0000_0010,
      gender_feminine:    0b0000_0000_0000_0000_0000_0000_0000_0100,
      gender_neuter:      0b0000_0000_0000_0000_0000_0000_0000_1000,
      number_singular:    0b0000_0000_0000_0000_0000_0000_0001_0000,
      number_plural:      0b0000_0000_0000_0000_0000_0000_0010_0000,
      case_nominative:    0b0000_0000_0000_0000_0000_0000_0100_0000,
      case_genitive:      0b0000_0000_0000_0000_0000_0000_1000_0000,
      case_dative:        0b0000_0000_0000_0000_0000_0001_0000_0000,
      case_accusative:    0b0000_0000_0000_0000_0000_0010_0000_0000,
      case_instrumental:  0b0000_0000_0000_0000_0000_0100_0000_0000,
      case_prepositional: 0b0000_0000_0000_0000_0000_1000_0000_0000,
      case_partitive:     0b0000_0000_0000_0000_0001_0000_0000_0000,
      case_locative:      0b0000_0000_0000_0000_0010_0000_0000_0000,
      voice_active:       0b0000_0000_0000_0000_0100_0000_0000_0000,
      voice_passive:      0b0000_0000_0000_0000_1000_0000_0000_0000,
      imperative:         0b0000_0000_0000_0001_0000_0000_0000_0000,
      tense_past:         0b0000_0000_0000_0010_0000_0000_0000_0000,
      tense_present:      0b0000_0000_0000_0100_0000_0000_0000_0000,
      tense_future:       0b0000_0000_0000_1000_0000_0000_0000_0000,
      degree_camparative: 0b0000_0000_0001_0000_0000_0000_0000_0000,
      degree_superlative: 0b0000_0000_0010_0000_0000_0000_0000_0000,
      short_form:         0b0000_0000_0100_0000_0000_0000_0000_0000,
      vovel_pair:         0b0000_0000_1000_0000_0000_0000_0000_0000,
    }
  end

  # @param [Lexeme] lexeme
  def lexeme=(lexeme)
    if lexeme.lexeme_type.slug != self.allowed_lexeme_type
      error = "Lexeme of type #{lexeme.lexeme_type.slug} if not allowed for this handler"
      raise ArgumentError.new(error)
    end
    @lexeme = lexeme
  end

  def declinable?
    @lexeme.declinable?
  end

  # @param [Integer] flag_name
  def wordform(flag_name = :infinitive)
    return if @lexeme.nil?

    flag = wordform_flags[flag_name].to_i
    prepare_wordforms.each do |flags, word|
      return word if flags & flag > 0
    end

    "[#{@lexeme.body}](#{flag_name})"
  end

  def inflect
    @lexeme.body
  end

  private

  def prepare_wordforms
    unless @wordforms.keys.any?
      @lexeme.wordforms.each do |wordform|
        @wordforms[wordform.flag] = wordform.word.body
      end
    end
    @wordforms
  end
end
