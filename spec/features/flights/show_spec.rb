require 'rails_helper'

RSpec.describe 'Flights Show Page' do
  before :each do
    @airline = create :airline
    @flight = create(:flight, airline_id: @airline.id)
    @passengers = create_list(:passenger, 200)
    @flight.passengers << @passengers
  end

  it 'can display details for a flight' do
    visit "/flights/#{@flight.id}"
    expect(current_path).to eq("/flights/#{@flight.id}")

    within '#flight-info' do
      expect(page).to have_content(@flight.number)
      expect(page).to have_content(@flight.date)
      expect(page).to have_content(@flight.time)
      expect(page).to have_content(@flight.departure_city)
      expect(page).to have_content(@flight.arrival_city)
    end

    within '#airline-info' do
      expect(page).to have_content("Name of airline: #{@airline.name}")
    end

    @flight.passengers.each do |flight_passenger|
      within "#passenger-#{flight_passenger.id}" do
        expect(page).to have_content(flight_passenger.name)
      end
    end
  end
end



# User Story 1, Flights Show Page
#
# As a visitor
# When I visit a flights show page ('/flights/:id')
# I see all of that flights information including:
#   - number
#   - date
#   - time
#   - departure city
#   - arrival city
# And I see the name of the airline this flight belongs
# And I see the names of all of the passengers on this flight
