class PassengersController < ApplicationController
  def show
    @passenger = Passenger.find(params[:id])
  end

  def update
    @passenger = Passenger.find(params[:id])
    flight = Flight.find(params[:flight_id])
    flight.passengers << @passenger

    redirect_to "/passengers/#{@passenger.id}"
  end
end
