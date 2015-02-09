class AdjectivesController < ApplicationController
  before_action :allow_authorized_only, except: [:index, :show]
  before_action :set_word, only: [:show, :edit, :update, :destroy]

  # get /adjectives
  def index
    @words = Adjective.order('nominative_masculine asc').page(params[:page] || 1).per(20)
  end

  # get /adjectives/new
  def new
    @word = Adjective.new
  end

  # post /adjectives
  def create
    @word = Adjective.new(word_parameters.merge(user: current_user, approved: true))
    if @word.save
      flash[:notice] = t('word.created')
      redirect_to @word
    else
      render action: :new
    end
  end

  # get /adjectives/:id
  def show
  end

  # get /adjectives/:id/edit
  def edit
  end

  # patch /adjectives/:id
  def update
    if @word.update(word_parameters)
      flash[:notice] = t('word.updated')
      redirect_to @word
    else
      render action: :edit
    end
  end

  # delete /adjectives/:id
  def destroy
    if @word.destroy
      flash[:notice] = t('word.destroyed')
    end

    redirect_to adjectives_path
  end

  protected

  def set_word
    @word = Adjective.find(params[:id])
  end

  def word_parameters
    allowed = []

    params.require(:adjective).permit(allowed)
  end
end
