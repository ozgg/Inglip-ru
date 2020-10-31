# frozen_string_literal: true

# Managing sentence patterns
class SentencePatternsController < AdminController
  include CreateAndModifyEntities

  # get /sentence_patterns/new
  def new
    @entity = SentencePattern.new
  end

  private

  def component_class
    Biovision::Components::CorporaComponent
  end
end
