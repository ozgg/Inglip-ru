# frozen_string_literal: true

namespace :porter do
  desc 'Port indeclinable lexemes'
  task indeclinable: :environment do
    porters = {}
    indeclinable = %w[
      adverb conjunction interjection parenthesis particle predicative
      preposition
    ]
    Dir.glob("#{Rails.root}/tmp/lexemes/**/*.yml").each_with_index do |path, index|
      type = File.basename(File.dirname(File.dirname(path)))
      i = File.basename(File.dirname(path))
      print "\r#{index}: #{type}/#{i}/#{File.basename(path)} "
      next unless indeclinable.include? type

      porters[type] ||= Porters::BasePorter[type]
      porters[type].parse(YAML.safe_load(File.open(path)))
    end

    puts
  end

  desc 'Port declinable lexemes'
  task declinable: :environment do
    porters = {}
    processable = %w[noun]
    Dir.glob("#{Rails.root}/tmp/lexemes/noun/**/*.yml").each_with_index do |path, index|
      type = File.basename(File.dirname(File.dirname(path)))
      i = File.basename(File.dirname(path))
      print "\r#{index}: #{type}/#{i}/#{File.basename(path)} "
      next unless processable.include? type

      porters[type] ||= Porters::BasePorter[type]
      porters[type].parse(YAML.safe_load(File.open(path)))
    end

    puts
  end
end
