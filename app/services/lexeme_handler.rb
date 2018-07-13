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
    when :adjective
      LexemeHandler::Adjective.new(lexeme)
    when :participle
      LexemeHandler::Participle.new(lexeme)
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

  # @return [Integer]
  def self.default_lexeme_flags
    0
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
      degree_comparative: 0b0000_0000_0001_0000_0000_0000_0000_0000,
      short_form:         0b0000_0000_0010_0000_0000_0000_0000_0000,
      vovel_pair:         0b0000_0000_0100_0000_0000_0000_0000_0000,
    }
  end

  # @param [Symbol]
  def self.wordform_flag(*keys)
    keys.map { |key| wordform_flags[key].to_i }.reduce(&:+)
  end

  # @param [Symbol]
  def self.lexeme_flag(*keys)
    keys.map { |key| lexeme_flags[key].to_i }.reduce(&:+)
  end

  # @param [Lexeme] lexeme
  def lexeme=(lexeme)
    if lexeme.lexeme_type.slug != self.class.allowed_lexeme_type
      error = "Lexeme of type #{lexeme.lexeme_type.slug} if not allowed for this handler"
      raise ArgumentError.new(error)
    end
    @lexeme = lexeme
  end

  def declinable?
    @lexeme.declinable?
  end

  # @param [Symbol] flag_name
  def flag?(flag_name)
    flag = self.class.lexeme_flags[flag_name].to_i

    @lexeme&.flags.to_i & flag == flag
  end

  # @param [Integer] flag
  def wordform(flag)
    return if @lexeme.nil?

    prepare_wordforms.each do |flags, word|
      return word if flags & flag == flag
    end

    nil
  end

  # @param [Integer] flag
  def wordform!(flag)
    return if @lexeme.nil?

    wordform(flag) || "[#{@lexeme.body}](#{flag})"
  end

  # @param [Integer] lexeme_flags
  # @param [Hash] wordforms
  def save(lexeme_flags, wordforms)
    @lexeme.update(flags: lexeme_flags.values.map(&:to_i).reduce(&:+).to_i)
    save_wordform(@lexeme.body, 1) # Save infinitive
    save_wordforms(wordforms)
  end

  # @param [String] text
  # @param [Integer] flag
  def save_wordform(text, flag)
    return if text.blank?
    word = Word.find_or_create_by(body: text)
    link = @lexeme.wordforms.find_by(word: word)
    if link.nil?
      link = @lexeme.wordforms.new(word: word, flags: flag)
    else
      link.flags |= flag
    end
    link.save
  end

  def inflect
    @lexeme.body
  end

  protected

  def prepare_wordforms
    return @wordforms if @lexeme&.id.nil?

    unless @wordforms.keys.any?
      @lexeme.wordforms.each do |wordform|
        @wordforms[wordform.flags] = wordform.word.body
      end
    end
    @wordforms
  end

  # @param [Hash] wordforms
  def save_wordforms(wordforms)
    wordforms.each do |flag, text|
      save_wordform(text, flag.to_i) unless text.blank?
    end
  end
end
