class AdverbsController < ApplicationController
  before_action :allow_authorized_only
  before_action :set_adverb, only: [:show, :edit, :update, :destroy]

  def index
    @words = Adverb.order('body asc').page(current_page).per(20)
  end

  def new
    @word = Adverb.new
  end

  def create
    @word = Adverb.new adverb_parameters
    if @word.save
      redirect_to @word
    else
      render :new
    end
  end

  def update
    if @word.update adverb_parameters
      redirect_to @word
    else
      render :edit
    end
  end

  def destroy
    @word.destroy
    redirect_to adverbs_path
  end

  protected

  def adverb_parameters
    params.require(:adverb).permit(:family, :is_comparative, :body, :comparative_degree)
  end

  def set_adverb
    @word = Adverb.find params[:id]
  end
end
