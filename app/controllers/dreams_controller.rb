class DreamsController < ApplicationController
  before_action :allow_authorized_only
  before_action :set_dream, only: [:show, :edit, :update, :destroy]

  # get /dreams
  def index
    @dreams = Dream.order('name asc').page(current_page).per(20)
  end

  # post /dreams
  def create
    counter = 0
    params.require(:dreams).to_s.split(/\r?\n/).each do |name|
      counter += 1 if Dream.create name: name.strip
    end
    flash[:notice] = counter
    redirect_to dreams_path
  end

  # patch /dreams/:id
  def update
    if @dream.update dream_parameters
      redirect_to @dream
    else
      render :edit
    end
  end

  # delete /dreams/:id
  def destroy
    @dream.destroy
    redirect_to dreams_path
  end

  protected

  def dream_parameters
    params.require(:dream).permit(:name)
  end

  def set_dream
    @dream = Dream.find params[:id]
  end
end
