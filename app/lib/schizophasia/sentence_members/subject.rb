# frozen_string_literal: true

module Schizophasia
  module SentenceMembers
    # Subject in sentence
    class Subject < SentenceMember
      def seed_flags
        self.flags = {
          use_apposition: sample(true, false)
        }
      end

      def prepare
        seed_flags
        @noun_handler = noun_handler
        parts << adjective_handler if flags[:use_apposition]
        parts << @noun_handler
      end

      def noun_handler
        handler = random_noun
        handler.declension_flags = %i[number_singular case_nominative]
        handler
      end

      def adjective_handler
        declension_flags = [number_flag, gender_flag, :case_nominative]
        handler = random_adjective
        handler.declension_flags = declension_flags
        handler
      end

      def number_flag
        mapping = {
          singular_only: :number_singular,
          plural_only: :number_plural,
          any: :number_singular
        }

        mapping[@noun_handler.number]
      end

      def gender_flag
        mapping = {
          masculine: :gender_masculine,
          feminine: :gender_feminine,
          neuter: :gender_neuter,
          mutual: sample(:gender_masculine, :gender_feminine)
        }

        mapping[@noun_handler.gender]
      end
    end
  end
end
