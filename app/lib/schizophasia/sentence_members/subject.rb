# frozen_string_literal: true

module Schizophasia
  module SentenceMembers
    # Subject in sentence
    class Subject < SentenceMember
      attr_accessor :case_valency
      attr_accessor :noun_handler, :adjective_handler, :participle_handler

      def seed_flags
        self.flags = {
          use_apposition: sample(true, false),
          use_modifier: sample(true, false),
          use_participle: sample(true, false)
        }
      end

      def build
        if case_valency.blank?
          noun_handler.declension_flags += [:case_nominative]
        else
          noun_handler.declension_flags += sample(case_valency)
        end
        prepare_modifier if flags[:use_modifier]
        parts << noun_handler.to_s
      end

      def prepare
        seed_flags
        prepare_noun_handler
      end

      def prepare_noun_handler
        handler = random_noun
        handler.declension_flags = %i[number_singular]
        self.noun_handler = handler
      end

      def prepare_modifier
        if flags[:use_participle]
          prepare_participle_handler
          parts << participle_handler
        else
          prepare_adjective_handler
          parts << adjective_handler
        end
      end

      def prepare_adjective_handler
        declension_flags = [number_flag, gender_flag, case_flag]
        handler = random_adjective
        handler.declension_flags = declension_flags
        self.adjective_handler = handler
      end

      def prepare_participle_handler
        handler = random_participle
        declension_flags = [number_flag, gender_flag, case_flag]
        declension_flags += handler.perfective? ? [:tense_past] : [:tense_present]
        handler.declension_flags = declension_flags
        self.participle_handler = handler
      end

      def number_flag
        mapping = {
          singular_only: :number_singular,
          plural_only: :number_plural,
          any: :number_singular
        }

        mapping[noun_handler.number]
      end

      def gender_flag
        mapping = {
          masculine: :gender_masculine,
          feminine: :gender_feminine,
          neuter: :gender_neuter,
          mutual: sample(:gender_masculine, :gender_feminine)
        }

        mapping[noun_handler.gender]
      end

      def case_flag
        noun_handler.grammatical_case_flag
      end
    end
  end
end
