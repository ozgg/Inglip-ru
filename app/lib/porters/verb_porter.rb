# frozen_string_literal: true

module Porters
  # Verb and derivatives (participle, gerund)
  class VerbPorter < BasePorter
    def handle
      prepare
      handle_verb(false, @data.dig('forms', 'active_voice'))
      handle_verb(true, @data.dig('forms', 'passive_voice'))
    end

    private

    # @param [Symbol] keys
    def flag(*keys)
      keys.map do |key|
        Biovision::Components::Words::VerbHandler.wordform_flags[key]
      end.sum
    end

    def prepare
      forms = {
        'нсв' => 0, 'нсв,' => 0,
        'св' => 1, 'св,' => 1,
        'св-нсв' => 2, 'св-нсв,' => 2
      }
      chunk = @data['context'].gsub(/^\([^)]+\)\s/, '').split(' ').first
      raise "Unknown verb form: #{chunk}" unless forms.key?(chunk)

      @form = forms[chunk]
    end

    def create(attributes, lexeme_data, wordforms)
      entity = @handler.create(attributes, lexeme_data)
      raise "Cannot save entity: #{entity.errors.messages}" unless entity.valid?

      @handler.wordforms = wordforms
    end

    def verb_forms(data, tense_flag)
      {
        flag(tense_flag, :number_singular, :person_first) => normalize(data.dig('present/future_tense', 'forms', 'singular', '1')),
        flag(tense_flag, :number_singular, :person_second) => normalize(data.dig('present/future_tense', 'forms', 'singular', '2')),
        flag(tense_flag, :number_singular, :person_third) => normalize(data.dig('present/future_tense', 'forms', 'singular', '3')),
        flag(tense_flag, :number_plural, :person_first) => normalize(data.dig('present/future_tense', 'forms', 'plural', '1')),
        flag(tense_flag, :number_plural, :person_second) => normalize(data.dig('present/future_tense', 'forms', 'plural', '2')),
        flag(tense_flag, :number_plural, :person_third) => normalize(data.dig('present/future_tense', 'forms', 'plural', '3')),
        flag(tense_flag, :gerund) => normalize(data.dig('present/future_tense', 'gerund')),
        flag(:imperative, :number_singular) => normalize(data.dig('imperative', 'forms', 'singular')),
        flag(:imperative, :number_plural) => normalize(data.dig('imperative', 'forms', 'plural')),
        flag(:tense_past, :number_singular, :gender_masculine) => normalize(data.dig('past_tense', 'forms', 'masculine')),
        flag(:tense_past, :number_singular, :gender_feminine) => normalize(data.dig('past_tense', 'forms', 'feminine')),
        flag(:tense_past, :number_singular, :gender_neuter) => normalize(data.dig('past_tense', 'forms', 'neuter')),
        flag(:tense_past, :number_plural) => normalize(data.dig('past_tense', 'forms', 'plural')),
        flag(:tense_past, :gerund) => normalize(data.dig('past_tense', 'gerund')),
      }
    end

    def handle_verb(passive, data)
      return if data.blank?

      if data.key?('present/future_tense')
        attributes = @attributes.dup
        lexeme_data = { form: @form }
        if passive
          lexeme_data['passive'] = '1'
          attributes[:context] = attributes[:context][0..244] + ' (passive)'
        end

        case @form
        when 0
          create(attributes, lexeme_data, verb_forms(data, :tense_present))
        when 1
          create(attributes, lexeme_data, verb_forms(data, :tense_future))
        else
          merged_forms = verb_forms(data, :tense_present).merge(verb_forms(data, :tense_future))
          create(attributes, lexeme_data, merged_forms)
        end
      end

      handle_participle(passive, data.dig('present_participle', 'forms'), data.dig('past_participle', 'forms'))
    end

    def handle_participle(passive, present, past)
      postfix = passive ? ' (passive)' : ''
      attributes = {
        lexeme_type: LexemeType['participle'],
        context: 'причастие от ' + @attributes[:context][0..230] + postfix,
        body: normalize(present&.dig('masculine', 'nominative') || past&.dig('masculine', 'nominative'))
      }
      lexeme_flags = {}
      lexeme_flags['passive'] = '1' if passive
      lexeme_flags['perfective'] = '1' if @form == 1

      return if Lexeme.exists?(attributes) || attributes[:body].blank?

      handler = Biovision::Components::Words::LexemeHandler.for_type(attributes[:lexeme_type])

      entity = handler.create(attributes, lexeme_flags)
      raise "Cannot save entity: #{entity.errors.messages}" unless entity.valid?

      handler.wordforms = participle_forms(present, flag(:tense_present)).merge(participle_forms(past, flag(:tense_past)))
    end

    def participle_forms(forms, tense_flag)
      return {} if forms.blank?

      mapping = flag_mapping
      result = {}

      forms.each do |outer_key, value|
        next if value.blank?
        next unless mapping[:outer].key?(outer_key.to_sym)

        flag = mapping[:outer][outer_key.to_sym] + tense_flag
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

    def flag_mapping
      flag_list = Biovision::Components::Words::ParticipleHandler.wordform_flags
      singular = flag_list[:number_singular]
      {
        outer: {
          masculine: singular + flag_list[:gender_masculine],
          feminine: singular + flag_list[:gender_feminine],
          neuter: singular + flag_list[:gender_neuter],
          plural: flag_list[:number_plural]
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
