class NounsController < ApplicationController
  before_action :allow_authorized_only
  before_action :set_noun, only: [:show, :edit, :update, :destroy]

  # get /nouns
  def index
    @words = Noun.order('nominative asc').page(current_page).per(20)
  end

  # get /nouns/new
  def new
    @word = Noun.new
  end

  # post /nouns
  def create
    @word = Noun.new(noun_parameters.merge(user: current_user, approved: true))
    if @word.save
      flash[:notice] = t('word.created')
      redirect_to @word
    else
      render :new
    end
  end

  # patch /nouns/:id
  def update
    if @word.update(noun_parameters)
      flash[:notice] = t('word.updated')
      redirect_to @word
    else
      render :edit
    end
  end

  # delete /nouns/:id
  def destroy
    if @word.destroy
      flash[:notice] = t('word.destroyed')
    end

    redirect_to nouns_path
  end

  protected

  def set_noun
    @word = Noun.find(params[:id])
  end

  def noun_parameters
    allowed = [
        :grammatical_gender, :grammatical_number, :animated, :common_gender, :mutual_gender,
        :nominative, :genitive, :dative, :accusative, :instrumental, :prepositional, :locative, :partitive,
        :plural_nominative, :plural_genitive, :plural_dative, :plural_accusative, :plural_instrumental,
        :plural_prepositional, :plural_locative, :plural_partitive
    ]

    params.require(:noun).permit(allowed)
  end
end
