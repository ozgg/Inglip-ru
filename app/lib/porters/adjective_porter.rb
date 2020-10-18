# frozen_string_literal: true

module Porters
  # Adjective
  class AdjectivePorter < BasePorter
    def lexeme_data
      {
        'qualitative' => @data.dig('forms', 'comparative').blank? ? '0' : '1'
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
      flag_list = Biovision::Components::Words::AdjectiveHandler.wordform_flags
      singular = flag_list[:number_singular]
      {
        outer: {
          masculine: singular + flag_list[:gender_masculine],
          feminine: singular + flag_list[:gender_feminine],
          neuter: singular + flag_list[:gender_neuter],
          plural: flag_list[:number_plural],
          comparative: flag_list[:comparative]
        },
        inner: {
          nominative: flag_list[:case_nominative],
          genitive: flag_list[:case_genitive],
          dative: flag_list[:case_dative],
          accusative_animate: flag_list[:case_accusative],
          instrumental: flag_list[:case_instrumental],
          locative: flag_list[:case_prepositional],
          short_form: flag_list[:short_form]
        }
      }
    end
  end
end
