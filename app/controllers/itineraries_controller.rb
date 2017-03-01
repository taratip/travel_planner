class ItinerariesController < ApplicationController
  before_action :set_itinerary, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user
  def index
    @itineraries = Itinerary.all
  end

  def show
  end

  def new
    @itinerary = Itinerary.new
  end

  def create
    @itinerary = Itinerary.new(itinerary_params)
    @itinerary.user = current_user

    if @itinerary.save
      redirect_to itinerary_path(@itinerary), notice: 'Itinerary was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @itinerary.user == current_user
      if @itinerary.update_attributes(itinerary_params)
        redirect_to itinerary_path(@itinerary), notice: 'Itinerary was successfully updated.'
      else
        render :edit
      end
    else
      render :file => "#{Rails.root}/public/404.html",  :status => 404
    end
  end

  def destroy
    if @itinerary.user == current_user
      @itinerary.destroy

      redirect_to itineraries_path, notice: 'The itinerary was deleted.'
    else
      render :file => "#{Rails.root}/public/404.html", :status => 404
    end
  end

  private
  def set_itinerary
    @itinerary = Itinerary.find(params[:id])
  end

  def itinerary_params
    params.require(:itinerary).permit(
      :name,
      :start_date,
      :end_date
    )
  end
end
