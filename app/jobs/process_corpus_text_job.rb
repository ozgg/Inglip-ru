# frozen_string_literal: true

# Process corpus text, find words, lexemes and add pending words
class ProcessCorpusTextJob < ApplicationJob
  queue_as :default

  # @param [Integer] id
  def perform(id)
    entity = CorpusText.find_by(id: id)

    return if entity.nil?

    processor = Biovision::Components::Corpora::TextProcessor.new(entity)
    processor.process
  end
end
