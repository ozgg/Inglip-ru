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

      def prepare
        seed_flags
        prepare_noun_handler
        if flags[:use_modifier]
          if flags[:use_participle]
            prepare_participle_handler
            parts << participle_handler.to_s
          else
            prepare_adjective_handler
            parts << adjective_handler.to_s
          end
        end
        parts << noun_handler.to_s
      end

      def prepare_noun_handler
        handler = random_noun
        handler.declension_flags = %i[number_singular]
        if case_valency.blank?
          handler.declension_flags += [:case_nominative]
        else
          handler.declension_flags += sample(*case_valency)
        end
        self.noun_handler = handler
      end

      def prepare_adjective_handler
        declension_flags = [number_flag, gender_flag, :case_nominative]
        handler = random_adjective
        handler.declension_flags = declension_flags
        self.adjective_handler = handler
      end

      def prepare_participle_handler
        handler = random_participle
        declension_flags = [number_flag, gender_flag, :case_nominative]
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
    end
  end
end
