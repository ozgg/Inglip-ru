class NounsController < ApplicationController
  before_action :allow_authorized_only, except: [:index, :show]
  before_action :set_noun, only: [:show, :edit, :update, :destroy]

  def index
    @nouns = Noun.page(params[:page] || 1).per(20)
  end

  def new
    @noun = Noun.new
  end

  def create
    @noun = Noun.new(noun_parameters.merge(user: current_user, approved: true))
    if @noun.save
      flash[:notice] = t('word.created')
      redirect_to @noun
    else
      render action: :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @noun.update(noun_parameters)
      flash[:notice] = t('word.updated')
      redirect_to @noun
    else
      render action: :edit
    end
  end

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
    allowed << [:nominative, :genitive, :dative, :instrumental, :prepositional, :has_locative, :has_partitive]
    allowed << [:plural_nominative, :plural_genitive, :plural_dative, :plural_instrumental, :plural_prepositional]

    params.require(:noun).permit(allowed)
  end
end
