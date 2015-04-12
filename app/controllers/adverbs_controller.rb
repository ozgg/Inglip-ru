class AdverbsController < ApplicationController
  before_action :allow_authorized_only
  before_action :set_adverb, only: [:show, :edit, :update, :destroy]

  def index
    @adverbs = Adverb.order('body asc').page(current_page).per(20)
  end

  def new
    @adverb = Adverb.new
  end

  def create
    @adverb = Adverb.new adverb_parameters
    if @adverb.save
      redirect_to @adverb
    else
      render :new
    end
  end

  def update
    if @adverb.update adverb_parameters
      redirect_to @adverb
    else
      render :edit
    end
  end

  def destroy
    @adverb.destroy
    redirect_to adverbs_path
  end

  protected

  def adverb_parameters
    params.require(:adverb).permit(:family, :is_comparative, :body, :comparative_degree)
  end

  def set_adverb
    @adverb = Adverb.find params[:id]
  end
end
