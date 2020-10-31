# frozen_string_literal: true

# Managing sentence patterns
class Admin::SentencePatternsController < AdminController
  include ListAndShowEntities

  # post /admin/sentence_patterns/analyze
  def analyze
    handler = Biovision::Components::Corpora::SentenceAnalyzer.new
    @patterns = handler.analyze(param_from_request(:text))
  end

  # post /admin/sentence_patterns
  def create
    @entity = SentencePattern.new(creation_parameters)
    if @entity.save
      head :created
    else
      head :bad_request
    end
  end

  private

  def component_class
    Biovision::Components::CorporaComponent
  end

  def creation_parameters
    permitted = SentencePattern.creation_parameters
    params.require(:sentence_pattern).permit(permitted)
  end
end
