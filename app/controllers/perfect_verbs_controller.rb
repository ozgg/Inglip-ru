class PerfectVerbsController < ApplicationController
  before_action :allow_authorized_only, except: [:index, :show]
  before_action :set_perfect_verb, only: [:show, :edit, :update, :destroy]

  # get /perfect_verbs
  def index
    @verbs = PerfectVerb.order('infinitive asc').page(params[:page] || 1).per(20)
  end

  # get /perfect_verbs/new
  def new
    @verb = PerfectVerb.new
  end

  # post /perfect_verbs
  def create
    @verb = PerfectVerb.new(verb_parameters.merge(user: current_user, approved: true))
    if @verb.save
      flash[:notice] = t('word.created')
      redirect_to @verb
    else
      render action: :new
    end
  end

  # get /perfect_verbs/:id
  def show
  end

  # get /perfect_verbs/:id/edit
  def edit
  end

  # patch /perfect_verbs/:id
  def update
    if @verb.update(verb_parameters)
      flash[:notice] = t('word.updated')
      redirect_to @verb
    else
      render action: :edit
    end
  end

  # delete /perfect_verbs/:id
  def destroy
    if @verb.destroy
      flash[:notice] = t('word.destroyed')
    end

    redirect_to perfect_verbs_path
  end

  protected

  def set_perfect_verb
    @verb = PerfectVerb.find(params[:id])
  end

  def verb_parameters
    allowed = [
        :has_reflexive, :has_reciprocal, :has_neuter, :valency, :infinitive, :imperative, :gerund,
        :passive_masculine, :passive_feminine, :passive_neuter, :passive_plural,
        :past_masculine, :past_feminine, :past_neuter, :past_plural,
        :future_first, :future_second, :future_third,
        :future_first_plural, :future_second_plural, :future_third_plural,
    ]

    params.require(:perfect_verb).permit(allowed)
  end
end
