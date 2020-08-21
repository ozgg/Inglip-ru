# frozen_string_literal: true

module Schizophasia
  module SentenceMembers
    # Gerund in sentence
    class Gerund < SentenceMember
      attr_accessor :verb_handler, :subject

      def seed_flags
        self.flags = {
          use_subject: sample(true, false),
          tense: sample(:tense_present, :tense_past)
        }
      end

      def prepare
        seed_flags
        prepare_verb_handler
        parts << verb_handler
        if flags[:use_subject]
          prepare_subject
          parts << subject.to_s
        end
      end

      def prepare_verb_handler
        handler = random_verb
        flags[:tense] = [:tense_past] if handler.perfective?
        handler.declension_flags = [:gerund, flags[:tense]]

        self.verb_handler = handler
      end

      def prepare_subject
        self.subject = SentenceMembers::Subject.new(generator)
        subject.flags[:use_apposition] = false
        subject.case_valency = case_valency
      end

      def case_valency
        [:case_instrumental]
        # verb_handler.valency
      end
    end
  end
end
