class CreateLexemeGroups < ActiveRecord::Migration[5.0]
  def up
    unless LexemeGroup.table_exists?
      create_table :lexeme_groups do |t|
        t.integer :lexemes_count, default: 0, null: false
        t.string :name, null: false
        t.string :slug, null: false
      end

      LexemeGroup.create! name: 'Имя существительное', slug: 'noun'
      LexemeGroup.create! name: 'Имя прилагательное', slug: 'adjective'
      LexemeGroup.create! name: 'Глагол', slug: 'verb'
      LexemeGroup.create! name: 'Причастие', slug: 'participle'
      LexemeGroup.create! name: 'Деепричастие', slug: 'gerund'
      LexemeGroup.create! name: 'Предлог', slug: 'preposition'
      LexemeGroup.create! name: 'Имя числительное', slug: 'numeral'
      LexemeGroup.create! name: 'Наречие', slug: 'adverb'
      LexemeGroup.create! name: 'Союз', slug: 'conjunction'
      LexemeGroup.create! name: 'Предикатив', slug: 'predicative'
      LexemeGroup.create! name: 'Междометие', slug: 'interjection'
      LexemeGroup.create! name: 'Местоимение', slug: 'pronoun'
      LexemeGroup.create! name: 'Частица', slug: 'participle'
      LexemeGroup.create! name: 'Имя собственное', slug: 'proper_name'
    end
  end

  def down
    if LexemeGroup.table_exists?
      drop_table :lexeme_groups
    end
  end
end
