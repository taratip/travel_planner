class FlightBookingsController < ApplicationController
  before_action :set_itinerary
  before_action :authenticate_user

  def new
    @flight_booking = FlightBooking.new
  end

  def create
    @flight_booking = FlightBooking.new(flight_booking_params)
    @flight_booking.itinerary = @itinerary

    if @flight_booking.save
      redirect_to itinerary_flight_booking_path(@itinerary, @flight_booking), notice: 'Flight booking was successfully created.'
    else
      render :new
    end
  end

  def show
    @flight_booking = @itinerary.flight_bookings.find(params[:id])
  end

  def edit
    @flight_booking = @itinerary.flight_bookings.find(params[:id])
  end

  def update
    if @itinerary.user == current_user
      @flight_booking = @itinerary.flight_bookings.find(params[:id])
      if @flight_booking.update_attributes(flight_booking_params)
        redirect_to itinerary_path(@itinerary),notice: 'Flight booking was successfully updated.'
      else
        render :edit
      end
    else
      render :file => "#{Rails.root}/public/404.html",  :status => 404
    end
  end

  def destroy
    if @itinerary.user == current_user
      @flight_booking = @itinerary.flight_bookings.find(params[:id])

      @flight_booking.destroy
      redirect_to itinerary_path(@itinerary), notice: 'The flight booking was deleted.'
    else
      render :file => "#{Rails.root}/public/404.html", :status => 404
    end
  end

  private

  def set_itinerary
    @itinerary = Itinerary.find(params[:itinerary_id])
  end

  def flight_booking_params
    params.require(:flight_booking).permit(
      :confirmation_number
    )
  end
end
