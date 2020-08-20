# frozen_string_literal: true

module Schizophasia
  module SentenceMembers
    # Predicate in sentence
    class Predicate < SentenceMember
      attr_accessor :verb_handler, :subject

      def prepare
        prepare_verb_handler
        parts << verb_handler
      end

      def build
        if verb_handler.perfective?
          verb_handler.declension_flags -= %i[tense_present person_third]
          verb_handler.declension_flags |= [:tense_past, subject.gender_flag]
        else
          verb_handler.declension_flags |= %i[tense_present]
        end
      end

      def prepare_verb_handler
        handler = random_verb
        handler.declension_flags = %i[person_third number_singular]

        self.verb_handler = handler
      end

      def case_valency
        verb_handler.valency
      end
    end
  end
end
