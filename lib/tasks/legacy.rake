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

  desc "TODO"
  task adjectives: :environment do
  end

  desc "TODO"
  task adverbs: :environment do
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
