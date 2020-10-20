# frozen_string_literal: true

module Porters
  # Numeral
  class NumeralPorter < BasePorter
    def lexeme_data
      {
        'adjective' => @data['context'] =~ /п\s/ ? '1' : '0'
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

    def flag_mapping
      flag_list = Biovision::Components::Words::NumeralHandler.wordform_flags
      singular = flag_list[:number_singular]
      {
        outer: {
          masculine: singular + flag_list[:gender_masculine],
          feminine: singular + flag_list[:gender_feminine],
          neuter: singular + flag_list[:gender_neuter],
          singular: singular,
          plural: flag_list[:number_plural],
        },
        inner: {
          nominative: flag_list[:case_nominative],
          genitive: flag_list[:case_genitive],
          dative: flag_list[:case_dative],
          accusative: flag_list[:case_accusative],
          accusative_inanimate: flag_list[:case_accusative],
          accusative_animate: flag_list[:case_accusative],
          instrumental: flag_list[:case_instrumental],
          locative: flag_list[:case_prepositional],
        }
      }
    end
  end
end
