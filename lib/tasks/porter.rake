# frozen_string_literal: true

namespace :porter do
  desc 'Port indeclinable lexemes'
  task indeclinable: :environment do
    porters = {}
    Dir.glob("#{Rails.root}/tmp/lexemes/**/*.yml").each_with_index do |path, index|
      type = File.basename(File.dirname(path))
      indeclinable = %w[
        adverb conjunction interjection parenthesis particle predicative
        preposition
      ]
      print "\r#{index}: #{type}/#{File.basename(path)} "
      next unless indeclinable.include? type

      porters[type] ||= Porters::BasePorter[type]
      porters[type].parse(YAML.safe_load(File.open(path)))
    end

    puts
  end
end
