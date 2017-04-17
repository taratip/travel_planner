class HotelBookingsController < ApplicationController
  before_action :set_itinerary
  before_action :authenticate_user

  def index
    @hotel_bookings = @itinerary.hotel_bookings.all
  end

  def new
    @hotel_booking = HotelBooking.new
  end

  def show
    @hotel_booking = @itinerary.hotel_bookings.find(params[:id])
  end

  def create
    @hotel_booking = HotelBooking.new(hotel_booking_params)
    @hotel_booking.itinerary = @itinerary

    if @hotel_booking.save
      redirect_to itinerary_path(@itinerary), notice: 'Lodging was successfully created.'
    else
      render :new
    end
  end

  def edit
    @hotel_booking = @itinerary.hotel_bookings.find(params[:id])
  end

  def update
    if @itinerary.user == current_user
      @hotel_booking = @itinerary.hotel_bookings.find(params[:id])
      if @hotel_booking.update_attributes(hotel_booking_params)
        redirect_to itinerary_hotel_booking_path(@itinerary, @hotel_booking),notice: 'Lodging was successfully updated.'
      else
        render :edit
      end
    else
      render :file => "#{Rails.root}/public/404.html",  :status => 404
    end
  end

  def destroy
    if @itinerary.user == current_user
      @hotel_booking = @itinerary.hotel_bookings.find(params[:id])

      @hotel_booking.destroy
      redirect_to itinerary_path(@itinerary), notice: 'Lodging was deleted.'
    else
      render :file => "#{Rails.root}/public/404.html", :status => 404
    end
  end

  private
  def set_itinerary
    @itinerary = Itinerary.find(params[:itinerary_id])
  end

  def hotel_booking_params
    params.require(:hotel_booking).permit(
      :location_name,
      :address,
      :phone_number,
      :confirmation_number,
      :arrival_date,
      :arrival_time,
      :departure_date,
      :departure_time,
      :note
    )
  end
end
