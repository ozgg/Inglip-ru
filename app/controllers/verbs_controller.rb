class VerbsController < ApplicationController
  before_action :allow_authorized_only, except: [:index, :show]
  before_action :set_verb, only: [:show, :edit, :update, :destroy]

  # get /verbs
  def index
    @verbs = Verb.page(params[:page] || 1).per(20)
  end

  # get /verbs/new
  def new
    @verb = Verb.new
  end

  # post /verbs
  def create
    @verb = Verb.new(verb_parameters.merge(user: current_user, approved: true))
    if @verb.save
      flash[:notice] = t('word.created')
      redirect_to @verb
    else
      render action: :new
    end
  end

  # get /verbs/:id
  def show
  end

  # get /verbs/:id/edit
  def edit
  end

  # patch /verbs/:id
  def update
    if @verb.update(verb_parameters)
      flash[:notice] = t('word.updated')
      redirect_to @verb
    else
      render action: :edit
    end
  end

  # delete /verbs/:id
  def destroy
    if @verb.destroy
      flash[:notice] = t('word.destroyed')
    end

    redirect_to verbs_path
  end

  protected

  def set_verb
    @verb = Verb.find(params[:id])
  end

  def verb_parameters
    allowed = [
         :has_reflexive, :has_reciprocal, :has_neuter, :valency, :infinitive, :imperative, :gerund,
         :present_first, :present_second, :present_third,
         :present_first_plural, :present_second_plural, :present_third_plural,
         :past_masculine, :past_feminine, :past_neuter, :past_plural,
    ]

    params.require(:verb).permit(allowed)
  end
end
