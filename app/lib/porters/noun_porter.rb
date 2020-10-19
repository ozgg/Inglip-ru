# frozen_string_literal: true

module Porters
  # Noun
  class NounPorter < BasePorter
    def lexeme_data
      {
        'animated' => (@data['context'][1] == 'о' || !(@data['flags'].include?('Api') || @data['flags'].include?('Asi'))) ? '1' : '0',
        'indeclinable' => @data['flags'].include?('Indecl.') ? '1' : '0',
        'has_partitive' => @data.dig('forms', 'singular', 'dative_2').blank? ? '0' : '1',
        'has_locative' => @data.dig('forms', 'singular', 'locative_2').blank? ? '0' : '1',
        number: grammatical_number.to_s,
        gender: grammatical_gender.to_s
      }
    end

    def wordforms
      return {} unless @data.key?('forms')

      mapping = flag_mapping
      result = {}
      @data['forms'].each do |outer_key, value|
        next if value.blank?
        next unless mapping[:outer].key?(outer_key.to_sym)

        flag = mapping[:outer][outer_key.to_sym]
        if value.is_a?(String)
          result[flag] = normalize(value)
        else
          value.each do |inner_key, inner_value|
            next if inner_value.blank?
            next unless mapping[:inner].key?(inner_key.to_sym)

            result[flag + mapping[:inner][inner_key.to_sym]] = normalize(inner_value)
          end
        end
      end

      result
    end

    private

    def grammatical_gender
      chunk = @data['context'].split(' ').first.to_s
      if chunk[0] == 'с'
        2
      elsif chunk.include? '/'
        3
      else
        chunk[0] == 'ж' ? 0 : 1
      end
    end

    def grammatical_number
      singular = @data.dig('forms', 'singular', 'nominative')
      plural = @data.dig('forms', 'plural', 'nominative')
      if singular.blank?
        plural.blank? ? 0 : 2
      elsif plural.blank?
        singular.blank? ? 0 : 1
      else
        0
      end
    end

    def flag_mapping
      flag_list = Biovision::Components::Words::NounHandler.wordform_flags
      {
        outer: {
          singular: flag_list[:number_singular],
          plural: flag_list[:number_plural]
        },
        inner: {
          nominative: flag_list[:case_nominative],
          genitive: flag_list[:case_genitive],
          genitive_2: flag_list[:partitive],
          dative: flag_list[:case_dative],
          accusative: flag_list[:case_accusative],
          instrumental: flag_list[:case_instrumental],
          locative: flag_list[:case_prepositional],
          locative_2: flag_list[:locative]
        }
      }
    end
  end
end
