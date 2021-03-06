# frozen_string_literal: true

namespace :legacy_import do
  desc 'Import nouns from legacy CSV'
  task nouns: :environment do
    file_name = "#{Rails.root}/tmp/import/legacy/nouns.csv"
    if File.exist?(file_name)
      importer = Biovision::Components::Legacy::NounImporter.new
      CSV.foreach(file_name, headers: true) do |row|
        print "\r#{row['nominative']}  "
        importer << row
      end
    else
      puts "Cannot find file #{file_name}"
    end

    puts "\nDone. Now we have #{LexemeType['noun'].lexemes.count} nouns."
  end

  desc 'Import imperfective verbs from legacy CSV'
  task verbs: :environment do
    file_name = "#{Rails.root}/tmp/import/legacy/verbs.csv"
    if File.exist?(file_name)
      importer = Biovision::Components::Legacy::VerbImporter.new
      CSV.foreach(file_name, headers: true) do |row|
        print "\r#{row['infinitive']}  "
        importer << row
      end
    else
      puts "Cannot find file #{file_name}"
    end

    puts "\nDone. Now we have #{LexemeType['verb'].lexemes.count} verbs."
  end

  desc 'Import adjectives and participles from legacy CSV'
  task adjectives: :environment do
    file_name = "#{Rails.root}/tmp/import/legacy/adjectives.csv"
    if File.exist?(file_name)
      importer = Biovision::Components::Legacy::AdjectiveImporter.new
      CSV.foreach(file_name, headers: true) do |row|
        print "\r#{row['nominative_masculine']}  "
        importer << row
      end
    else
      puts "Cannot find file #{file_name}"
    end

    puts "\nDone. Now we have #{LexemeType['adjective'].lexemes.count} adjectives."
    puts "Also now we have #{LexemeType['participle'].lexemes.count} participles."
  end

  desc 'Import prepositions from legacy CSV'
  task prepositions: :environment do
    file_name = "#{Rails.root}/tmp/import/legacy/prepositions.csv"
    if File.exist?(file_name)
      importer = Biovision::Components::Legacy::PrepositionImporter.new
      CSV.foreach(file_name, headers: true) do |row|
        importer << row
      end
    else
      puts "Cannot find file #{file_name}"
    end

    puts "Done. Now we have #{LexemeType['preposition'].lexemes.count} prepositions."
  end

  desc 'Import perective verbs from legacy CSV'
  task perfective_verbs: :environment do
    file_name = "#{Rails.root}/tmp/import/legacy/perfective_verbs.csv"
    if File.exist?(file_name)
      importer = Biovision::Components::Legacy::VerbImporter.new
      CSV.foreach(file_name, headers: true) do |row|
        print "\r#{row['infinitive']}  "
        importer << row
      end
    else
      puts "Cannot find file #{file_name}"
    end

    puts "\nDone. Now we have #{LexemeType['verb'].lexemes.count} verbs."
  end

  desc 'Import adverbs from legacy CSV'
  task adverbs: :environment do
    file_name = "#{Rails.root}/tmp/import/legacy/adverbs.csv"
    if File.exist?(file_name)
      importer = Biovision::Components::Legacy::AdverbImporter.new
      CSV.foreach(file_name, headers: true) do |row|
        importer << row
      end
    else
      puts "Cannot find file #{file_name}"
    end

    puts "Done. Now we have #{LexemeType['adverb'].lexemes.count} adverbs."
  end
end
