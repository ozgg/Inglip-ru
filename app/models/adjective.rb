class Adjective < ActiveRecord::Base
  belongs_to :user
  validates_uniqueness_of :nominative_masculine
  validates_presence_of :nominative_masculine, :nominative_feminine, :nominative_neuter, :nominative_plural
  validates_presence_of :genitive_masculine, :genitive_feminine, :genitive_neuter, :genitive_plural
  validates_presence_of :dative_masculine, :dative_feminine, :dative_neuter, :dative_plural
  validates_presence_of :accusative_masculine, :accusative_feminine, :accusative_neuter, :accusative_plural
  validates_presence_of :instrumental_masculine, :instrumental_feminine, :instrumental_neuter, :instrumental_plural
  validates_presence_of :prepositional_masculine, :prepositional_feminine, :prepositional_neuter, :prepositional_plural

  def canonical_form
    nominative_masculine
  end

  def decline(gender, number, grammatical_case)
    case grammatical_case
      when :nominative
        in_nominative gender, number
      when :genitive
        in_genitive gender, number
      when :dative, :partitive
        in_dative gender, number
      when :accusative
        in_accusative gender, number
      when :instrumental
        in_instrumental gender, number
      when :prepositional, :locative
        in_prepositional gender, number
      else
        "?unknown adjective case: #{grammatical_case}"
    end
  end

  def in_nominative(gender, number)
    if number === :single
      case gender
        when :masculine
          nominative_masculine
        when :feminine
          nominative_feminine
        when :neuter
          nominative_neuter
        else
          "?unknown adjective gender: #{gender}"
      end
    else
      nominative_plural
    end
  end

  def in_genitive(gender, number)
    if number === :single
      case gender
        when :masculine
          genitive_masculine
        when :feminine
          genitive_feminine
        when :neuter
          genitive_neuter
        else
          "?unknown adjective gender: #{gender}"
      end
    else
      genitive_plural
    end
  end

  def in_dative(gender, number)
    if number === :single
      case gender
        when :masculine
          dative_masculine
        when :feminine
          dative_feminine
        when :neuter
          dative_neuter
        else
          "?unknown adjective gender: #{gender}"
      end
    else
      dative_plural
    end
  end

  def in_accusative(gender, number)
    if number === :single
      case gender
        when :masculine
          accusative_masculine
        when :feminine
          accusative_feminine
        when :neuter
          accusative_neuter
        else
          "?unknown adjective gender: #{gender}"
      end
    else
      accusative_plural
    end
  end

  def in_instrumental(gender, number)
    if number === :single
      case gender
        when :masculine
          instrumental_masculine
        when :feminine
          instrumental_feminine
        when :neuter
          instrumental_neuter
        else
          "?unknown adjective gender: #{gender}"
      end
    else
      instrumental_plural
    end
  end

  def in_prepositional(gender, number)
    if number === :single
      case gender
        when :masculine
          prepositional_masculine
        when :feminine
          prepositional_feminine
        when :neuter
          prepositional_neuter
        else
          "?unknown adjective gender: #{gender}"
      end
    else
      prepositional_plural
    end
  end
end
