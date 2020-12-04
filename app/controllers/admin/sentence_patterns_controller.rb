# frozen_string_literal: true

# Managing sentence patterns
class Admin::SentencePatternsController < AdminController
  include CrudEntities

  before_action :set_entity, except: %i[analyze check create index new]

  # get /admin/sentence_patterns/:id/sample
  def sample
    set_entity
    seed = params.key?(:seed) ? params[:seed] : Random.new_seed
    generator = Random.new(seed)
    @builder = Biovision::Components::Corpora::SentenceBuilder.new(generator)
  end

  # post /admin/sentence_patterns/analyze
  def analyze
    handler = Biovision::Components::Corpora::SentenceAnalyzer.new
    @patterns = handler.analyze(param_from_request(:text))
  end

  # post /admin/sentence_patterns
  # def create
  #   @entity = SentencePattern.new(creation_parameters)
  #   if @entity.save
  #     head :created
  #   else
  #     head :bad_request
  #   end
  # end

  private

  def component_class
    Biovision::Components::CorporaComponent
  end

  def creation_parameters
    permitted = SentencePattern.creation_parameters
    params.require(:sentence_pattern).permit(permitted)
  end
end
