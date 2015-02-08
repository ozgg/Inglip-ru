class Verb < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :infinitive
  validates_uniqueness_of :infinitive

  def decline(tense, person, gender, number)
    case tense
      when :past
        past_tense gender, number
      when :present
        present_tense person, number
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

  def present_tense(person, number)
    case person
      when :first
        number === :single ? present_first : present_first_plural
      when :second
        number === :single ? present_second : present_second_plural
      when :third
        number === :single ? present_third : present_third_plural
      else
        infinitive + ' ?present'
    end
  end

  def future_tense(person, number)
    case person
      when :first
        prefix = (number === :single ? 'буду' : 'будем')
      when :second
        prefix = (number === :single ? 'будешь' : 'будете')
      when :third
        prefix = (number === :single ? 'будет' : 'будут')
      else
        prefix = 'future? '
    end

    "#{prefix} #{infinitive}"
  end
end
