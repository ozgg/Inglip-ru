class PartOfSpeech::Verb < PartOfSpeech

  def self.indicators
    super.merge(active_voice).merge(passive_voice)
  end

  # Глагол совершенного вида?
  def perfective?
    @lexeme.data['perfective']
  end

  # Глагол несовершенного вида?
  def imperfective?
    @lexeme.data['imperfective']
  end

  protected

  def self.active_voice
    {
        # present/future tense
        active_singular_first: 1, active_singular_second: 2, active_singular_third: 3,
        active_plural_first: 4, active_plural_second: 5, active_plural_third: 6,
        active_gerund: 7,
        # Past tense
        active_past_masculine: 11, active_past_feminine: 12, active_past_neuter: 13, active_past_plural: 14,
        active_past_gerund: 15,
        # Imperative
        active_imperative_singular: 21, active_imperative_plural: 22,
        # Present participle
        active_present_participle_nominative_masculine: 31, active_present_participle_genitive_masculine: 32,
        active_present_participle_dative_masculine: 33, active_present_participle_accusative_animate_masculine: 34,
        active_present_participle_accusative_inanimate_masculine: 35,
        active_present_participle_instrumental_masculine: 36, active_present_participle_prepositional_masculine: 37,
        active_present_participle_nominative_feminine: 41, active_present_participle_genitive_feminine: 42,
        active_present_participle_dative_feminine: 43, active_present_participle_accusative_animate_feminine: 44,
        active_present_participle_accusative_inanimate_feminine: 45,
        active_present_participle_instrumental_feminine: 46, active_present_participle_prepositional_feminine: 47,
        active_present_participle_nominative_neuter: 51, active_present_participle_genitive_neuter: 52,
        active_present_participle_dative_neuter: 53, active_present_participle_accusative_animate_neuter: 54,
        active_present_participle_accusative_inanimate_neuter: 55, active_present_participle_instrumental_neuter: 56,
        active_present_participle_prepositional_neuter: 57,
        active_present_participle_nominative_plural: 61, active_present_participle_genitive_plural: 62,
        active_present_participle_dative_plural: 63, active_present_participle_accusative_animate_plural: 64,
        active_present_participle_accusative_inanimate_plural: 65, active_present_participle_instrumental_plural: 66,
        active_present_participle_prepositional_plural: 67,
        # Past participle
        active_past_participle_nominative_masculine: 71, active_past_participle_genitive_masculine: 72,
        active_past_participle_dative_masculine: 73, active_past_participle_accusative_animate_masculine: 74,
        active_past_participle_accusative_inanimate_masculine: 75, active_past_participle_instrumental_masculine: 76,
        active_past_participle_prepositional_masculine: 77,
        active_past_participle_nominative_feminine: 81, active_past_participle_genitive_feminine: 82,
        active_past_participle_dative_feminine: 83, active_past_participle_accusative_animate_feminine: 84,
        active_past_participle_accusative_inanimate_feminine: 85, active_past_participle_instrumental_feminine: 86,
        active_past_participle_prepositional_feminine: 87,
        active_past_participle_nominative_neuter: 91, active_past_participle_genitive_neuter: 92,
        active_past_participle_dative_neuter: 93, active_past_participle_accusative_animate_neuter: 94,
        active_past_participle_accusative_inanimate_neuter: 95, active_past_participle_instrumental_neuter: 96,
        active_past_participle_prepositional_neuter: 97,
        active_past_participle_nominative_plural: 101, active_past_participle_genitive_plural: 102,
        active_past_participle_dative_plural: 103, active_past_participle_accusative_animate_plural: 104,
        active_past_participle_accusative_inanimate_plural: 105, active_past_participle_instrumental_plural: 106,
        active_past_participle_prepositional_plural: 107,
    }
  end

  def self.passive_voice
    {
        # present/future tense
        passive_singular_first: 201, passive_singular_second: 202, passive_singular_third: 203,
        passive_plural_first: 204, passive_plural_second: 205, passive_plural_third: 206,
        passive_gerund: 207,
        # Past tense
        passive_past_masculine: 211, passive_past_feminine: 212, passive_past_neuter: 213, passive_past_plural: 214,
        passive_past_gerund: 215,
        # Imperative
        passive_imperative_singular: 221, passive_imperative_plural: 222,
        # Present participle
        passive_present_participle_nominative_masculine: 231, passive_present_participle_genitive_masculine: 232,
        passive_present_participle_dative_masculine: 233, passive_present_participle_accusative_animate_masculine: 234,
        passive_present_participle_accusative_inanimate_masculine: 235,
        passive_present_participle_instrumental_masculine: 236, passive_present_participle_prepositional_masculine: 237,
        passive_present_participle_short_masculine: 238,
        passive_present_participle_nominative_feminine: 241, passive_present_participle_genitive_feminine: 242,
        passive_present_participle_dative_feminine: 243, passive_present_participle_accusative_animate_feminine: 244,
        passive_present_participle_accusative_inanimate_feminine: 245,
        passive_present_participle_instrumental_feminine: 246, passive_present_participle_prepositional_feminine: 247,
        passive_present_participle_short_feminine: 248,
        passive_present_participle_nominative_neuter: 251, passive_present_participle_genitive_neuter: 252,
        passive_present_participle_dative_neuter: 253, passive_present_participle_accusative_animate_neuter: 254,
        passive_present_participle_accusative_inanimate_neuter: 255,
        passive_present_participle_instrumental_neuter: 256, passive_present_participle_prepositional_neuter: 257,
        passive_present_participle_short_neuter: 258,
        passive_present_participle_nominative_plural: 261, passive_present_participle_genitive_plural: 262,
        passive_present_participle_dative_plural: 263, passive_present_participle_accusative_animate_plural: 264,
        passive_present_participle_accusative_inanimate_plural: 265,
        passive_present_participle_instrumental_plural: 266, passive_present_participle_prepositional_plural: 267,
        passive_present_participle_short_plural: 168,
        # Past participle
        passive_past_participle_nominative_masculine: 271, passive_past_participle_genitive_masculine: 272,
        passive_past_participle_dative_masculine: 273, passive_past_participle_accusative_animate_masculine: 274,
        passive_past_participle_accusative_inanimate_masculine: 275,
        passive_past_participle_instrumental_masculine: 276, passive_past_participle_prepositional_masculine: 277,
        passive_past_participle_short_masculine: 278,
        passive_past_participle_nominative_feminine: 281, passive_past_participle_genitive_feminine: 282,
        passive_past_participle_dative_feminine: 283, passive_past_participle_accusative_animate_feminine: 284,
        passive_past_participle_accusative_inanimate_feminine: 285, passive_past_participle_instrumental_feminine: 286,
        passive_past_participle_prepositional_feminine: 287, passive_past_participle_short_feminine: 288,
        passive_past_participle_nominative_neuter: 291, passive_past_participle_genitive_neuter: 292,
        passive_past_participle_dative_neuter: 293, passive_past_participle_accusative_animate_neuter: 294,
        passive_past_participle_accusative_inanimate_neuter: 295, passive_past_participle_instrumental_neuter: 296,
        passive_past_participle_prepositional_neuter: 297, passive_past_participle_short_neuter: 298,
        passive_past_participle_nominative_plural: 301, passive_past_participle_genitive_plural: 302,
        passive_past_participle_dative_plural: 303, passive_past_participle_accusative_animate_plural: 304,
        passive_past_participle_accusative_inanimate_plural: 305, passive_past_participle_instrumental_plural: 306,
        passive_past_participle_prepositional_plural: 307, passive_past_participle_short_plural: 308,
    }
  end
end
