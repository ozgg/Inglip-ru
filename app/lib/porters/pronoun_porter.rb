# frozen_string_literal: true

module Porters
  # Pronoun
  class PronounPorter < BasePorter
    def lexeme_data
      @adjective = @data['context'][1] == 'п' || @data['context'][3] == 'п'
      {
        'adjective' => @adjective ? '1' : '0'
      }
    end

    def wordforms
      return {} unless @data.key?('forms')

      mapping = flag_mapping
      result = {}
      @data['forms'].each do |outer_key, value|
        next if value.blank?
        next unless mapping[:outer].key?(outer_key.to_sym)

        flag = @adjective ? mapping[:outer][outer_key.to_sym] : 0
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
      flag_list = Biovision::Components::Words::PronounHandler.wordform_flags
      singular = flag_list[:number_singular]
      {
        outer: {
          masculine: singular + flag_list[:gender_masculine],
          feminine: singular + flag_list[:gender_feminine],
          neuter: singular + flag_list[:gender_neuter],
          plural: flag_list[:number_plural],
        },
        inner: {
          nominative: flag_list[:case_nominative],
          genitive: flag_list[:case_genitive],
          dative: flag_list[:case_dative],
          accusative_animate: flag_list[:case_accusative],
          instrumental: flag_list[:case_instrumental],
          locative: flag_list[:case_prepositional],
        }
      }
    end
  end
end
