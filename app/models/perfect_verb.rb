class PerfectVerb < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :infinitive
  validates_uniqueness_of :infinitive

  def decline(tense, person, gender, number)
    case tense
      when :past
        past_tense gender, number
      when :present
        passive_mood gender, number
      when :future
        future_tense person, number
      else
        infinitive + ' ?tense'
    end
  end

  def past_tense(gender, number)
    if number === :single
      case gender
        when :feminine
          past_feminine
        when :masculine
          past_masculine
        when :neuter
          past_neuter
        else
          infinitive + " ?past for #{gender}"
      end
    else
      past_plural
    end
  end

  def passive_mood(gender, number)
    if number === :single
      case gender
        when :feminine
          passive_feminine
        when :masculine
          passive_masculine
        when :neuter
          passive_neuter
        else
          infinitive + " ?passive for #{gender}"
      end
    else
      passive_plural
    end
  end

  def future_tense(person, number)
    case person
      when :first
        number === :single ? future_first : future_first_plural
      when :second
        number === :single ? future_second : future_second_plural
      when :third
        number === :single ? future_third : future_third_plural
      else
        infinitive + ' ?future'
    end
  end

  def passive_addable?
    has_reflexive? || has_reciprocal? || has_neuter?
  end
end
