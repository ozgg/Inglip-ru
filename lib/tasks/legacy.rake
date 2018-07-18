namespace :legacy do
  desc "Import nouns from legacy CSV data"
  task nouns: :environment do
    require 'csv'
    csv_file = "#{Rails.root}/tmp/legacy/nouns.csv"
    type     = LexemeType.find_by!(slug: 'noun')

    puts "Importing legacy nouns from #{csv_file}..."
    CSV.parse(File.read(csv_file), headers: true) do |line|
      infinitive = line['nominative']
      print "\r#{infinitive}    "

      next if type.lexemes.exists?(body: infinitive)

      lexeme  = Lexeme.new(lexeme_type: type, body: infinitive)
      handler = LexemeHandler::Noun.new(lexeme)
      flags   = LexemeHandler::Noun.lexeme_flags
      c       = handler.class

      has_locative      = line['has_locative'] == 't'
      has_partitive     = line['has_partitive'] == 't'
      lexeme_flags      = {}

      lexeme_flags[:gm] = flags[:gender_masculine] if line['grammatical_gender'] == '0'
      lexeme_flags[:gf] = flags[:gender_feminine] if line['grammatical_gender'] == '1'
      lexeme_flags[:gn] = flags[:gender_neuter] if line['grammatical_gender'] == '2'
      lexeme_flags[:a]  = flags[:animated] if line['animated'] == 't'
      lexeme_flags[:hl] = flags[:has_locative] if has_locative
      lexeme_flags[:hp] = flags[:has_partitive] if has_partitive
      case line['grammatical_number']
      when '0'
        lexeme_flags[:sf] = flags[:singular_form]
        lexeme_flags[:pf] = flags[:plural_form]
      when '1'
        lexeme_flags[:sf] = flags[:singular_form]
      else
        lexeme_flags[:pf] = flags[:plural_form]
      end

      wordforms = {
        c.wordform_flag(:number_singular, :case_nominative)    => line['nominative'],
        c.wordform_flag(:number_singular, :case_genitive)      => line['genitive'],
        c.wordform_flag(:number_singular, :case_dative)        => line['dative'],
        c.wordform_flag(:number_singular, :case_accusative)    => line['accusative'],
        c.wordform_flag(:number_singular, :case_instrumental)  => line['instrumental'],
        c.wordform_flag(:number_singular, :case_prepositional) => line['prepositional'],
        c.wordform_flag(:number_plural, :case_nominative)      => line['plural_nominative'],
        c.wordform_flag(:number_plural, :case_genitive)        => line['plural_genitive'],
        c.wordform_flag(:number_plural, :case_dative)          => line['plural_dative'],
        c.wordform_flag(:number_plural, :case_accusative)      => line['plural_accusative'],
        c.wordform_flag(:number_plural, :case_instrumental)    => line['plural_instrumental'],
        c.wordform_flag(:number_plural, :case_prepositional)   => line['plural_prepositional']
      }

      if has_partitive
        wordforms[c.wordform_flag(:number_singular, :case_partitive)] = line['partitive']
        wordforms[c.wordform_flag(:number_plural, :case_partitive)]   = line['plural_partitive']
      end

      if has_locative
        wordforms[c.wordform_flag(:number_singular, :case_locative)] = line['locative']
        wordforms[c.wordform_flag(:number_plural, :case_locative)]   = line['plural_locative']
      end

      handler.save(lexeme_flags, wordforms)
    end

    puts "\nDone."
  end

  desc "Import adjectives and participles from legacy CSV data"
  task adjectives: :environment do
    require 'csv'
    csv_file = "#{Rails.root}/tmp/legacy/adjectives.csv"
    type_a   = LexemeType.find_by!(slug: 'adjective')
    type_p   = LexemeType.find_by!(slug: 'participle')

    puts "Importing legacy adjectives/participles from #{csv_file}..."
    CSV.parse(File.read(csv_file), headers: true) do |line|
      infinitive = line['nominative_masculine']
      print "\r#{infinitive}    "

      type = line['participle'] == 't' ? type_p : type_a

      next if type.lexemes.exists?(body: infinitive)

      lexeme  = Lexeme.new(lexeme_type: type, body: infinitive)
      handler = LexemeHandler.handler(lexeme)
      c       = handler.class
      flags   = c.lexeme_flags

      qualitative      = line['qualitative'] == 't'
      superlative      = line['superlative'] == 't'
      lexeme_flags     = {}

      lexeme_flags[:q] = flags[:qualitative] if qualitative
      lexeme_flags[:s] = flags[:superlative] if superlative

      wordforms = {
        c.wordform_flag(:number_singular, :gender_masculine, :case_nominative)    => line['nominative_masculine'],
        c.wordform_flag(:number_singular, :gender_masculine, :case_genitive)      => line['genitive_masculine'],
        c.wordform_flag(:number_singular, :gender_masculine, :case_dative)        => line['dative_masculine'],
        c.wordform_flag(:number_singular, :gender_masculine, :case_accusative)    => line['accusative_masculine'],
        c.wordform_flag(:number_singular, :gender_masculine, :case_instrumental)  => line['instrumental_masculine'],
        c.wordform_flag(:number_singular, :gender_masculine, :case_prepositional) => line['prepositional_masculine'],
        c.wordform_flag(:number_singular, :gender_feminine, :case_nominative)     => line['nominative_feminine'],
        c.wordform_flag(:number_singular, :gender_feminine, :case_genitive)       => line['genitive_feminine'],
        c.wordform_flag(:number_singular, :gender_feminine, :case_dative)         => line['dative_feminine'],
        c.wordform_flag(:number_singular, :gender_feminine, :case_accusative)     => line['accusative_feminine'],
        c.wordform_flag(:number_singular, :gender_feminine, :case_instrumental)   => line['instrumental_feminine'],
        c.wordform_flag(:number_singular, :gender_feminine, :case_prepositional)  => line['prepositional_feminine'],
        c.wordform_flag(:number_singular, :gender_neuter, :case_nominative)       => line['nominative_neuter'],
        c.wordform_flag(:number_singular, :gender_neuter, :case_genitive)         => line['genitive_neuter'],
        c.wordform_flag(:number_singular, :gender_neuter, :case_dative)           => line['dative_neuter'],
        c.wordform_flag(:number_singular, :gender_neuter, :case_accusative)       => line['accusative_neuter'],
        c.wordform_flag(:number_singular, :gender_neuter, :case_instrumental)     => line['instrumental_neuter'],
        c.wordform_flag(:number_singular, :gender_neuter, :case_prepositional)    => line['prepositional_neuter'],
        c.wordform_flag(:number_plural, :case_nominative)                         => line['nominative_plural'],
        c.wordform_flag(:number_plural, :case_genitive)                           => line['genitive_plural'],
        c.wordform_flag(:number_plural, :case_dative)                             => line['dative_plural'],
        c.wordform_flag(:number_plural, :case_accusative)                         => line['accusative_plural'],
        c.wordform_flag(:number_plural, :case_instrumental)                       => line['instrumental_plural'],
        c.wordform_flag(:number_plural, :case_prepositional)                      => line['prepositional_plural']
      }
      unless line['comparative'].blank?
        wordforms[c.wordform_flag(:degree_comparative)] = line['comparative']
      end

      handler.save(lexeme_flags, wordforms)
    end

    puts "\nDone."
  end

  desc "Import adverbs from legacy CSV data"
  task adverbs: :environment do
    require 'csv'
    csv_file = "#{Rails.root}/tmp/legacy/adverbs.csv"
    type     = LexemeType.find_by!(slug: 'adverb')

    puts "Importing legacy adjectives/participles from #{csv_file}..."
    CSV.parse(File.read(csv_file), headers: true) do |line|
      infinitive = line['body']
      print "\r#{infinitive}    "

      next if type.lexemes.exists?(body: infinitive)

      lexeme  = Lexeme.new(lexeme_type: type, body: infinitive)
      handler = LexemeHandler.handler(lexeme)
      c       = handler.class
      flags   = c.lexeme_flags

      lexeme_flags = {}
      wordforms    = {}
      unless line['comparative_degree'].blank?
        wordforms[c.wordform_flag(:degree_comparative)] = line['comparative_degree']

        lexeme_flags[:c] = flags[:qualitative]
      end

      handler.save(lexeme_flags, wordforms)
    end

    puts "\nDone."
  end

  desc "TODO"
  task perfect_verbs: :environment do
  end

  desc "TODO"
  task prepositions: :environment do
  end

  desc "TODO"
  task verbs: :environment do
  end

end
