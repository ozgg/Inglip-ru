class NounsController < ApplicationController
  before_action :allow_authorized_only, except: [:index, :show]
  before_action :set_noun, only: [:show, :edit, :update, :destroy]

  # get /nouns
  def index
    @nouns = Noun.order('nominative asc').page(params[:page] || 1).per(20)
  end

  # get /nouns/new
  def new
    @noun = Noun.new
  end

  # post /nouns
  def create
    @noun = Noun.new(noun_parameters.merge(user: current_user, approved: true))
    if @noun.save
      flash[:notice] = t('word.created')
      redirect_to @noun
    else
      render action: :new
    end
  end

  # get /nouns/:id
  def show
  end

  # get /nouns/:id/edit
  def edit
  end

  # patch /nouns/:id
  def update
    if @noun.update(noun_parameters)
      flash[:notice] = t('word.updated')
      redirect_to @noun
    else
      render action: :edit
    end
  end

  # delete /nouns/:id
  def destroy
    if @noun.destroy
      flash[:notice] = t('word.destroyed')
    end

    redirect_to nouns_path
  end

  protected

  def set_noun
    @noun = Noun.find(params[:id])
  end

  def noun_parameters
    allowed = [:grammatical_gender, :grammatical_number, :animated, :common_gender, :mutual_gender]
    allowed << [:nominative, :genitive, :dative, :accusative, :instrumental, :prepositional, :has_locative, :has_partitive]
    allowed << [:plural_nominative, :plural_genitive, :plural_dative, :plural_accusative, :plural_instrumental, :plural_prepositional]

    params.require(:noun).permit(allowed)
  end
end
