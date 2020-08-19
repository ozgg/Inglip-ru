# frozen_string_literal: true

module Schizophasia
  module SentenceMembers
    # Predicate in sentence
    class Predicate < SentenceMember
      def prepare
        handler = random_verb
        handler.declension_flags = %i[tense_present number_singular person_third]
        parts << handler
      end
    end
  end
end
