class CreateLexemeTypes < ActiveRecord::Migration[5.2]
  def up
    unless LexemeType.table_exists?
      create_table :lexeme_types do |t|
        t.integer :lexemes_count, default: 0, null: false
        t.string :name
        t.string :slug
      end

      create_lexeme_types
      create_privileges
    end
  end

  def down
    if LexemeType.table_exists?
      drop_table :lexeme_types
    end
  end

  private

  def create_lexeme_types
    collection = {
      noun: 'Имя существительное',
      adjective: 'Имя прилагательное',
      verb: 'Глагол',
      participle: 'Причастие',
      gerund: 'Деепричастие',
      preposition: 'Предлог',
      numeral: 'Имя числительное',
      adverb: 'Наречие',
      conjunction: 'Союз',
      predicative: 'Предикатив',
      interjection: 'Междометие',
      pronoun: 'Местоимение',
      particle: 'Частица',
      proper_name: 'Имя собственное'
    }

    collection.each do |slug, name|
      LexemeType.create!(slug: slug, name: name)
    end
  end

  def create_privileges
    Privilege.create(slug: 'word_manager', name: 'Управляющий словами')
  end
end
