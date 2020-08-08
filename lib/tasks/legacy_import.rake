# frozen_string_literal: true

namespace :legacy_import do
  desc 'Import nouns from legacy CSV'
  task nouns: :environment do

  end

  desc 'Import imperfective verbs from legacy CSV'
  task verbs: :environment do
  end

  desc 'Import adjectives from legacy CSV'
  task adjectives: :environment do
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

    puts "Done. Now we have #{LexemeType['preposision'].lexemes.count} prepositions."
  end

  desc 'Import perective verbs from legacy CSV'
  task perfective_verbs: :environment do
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
