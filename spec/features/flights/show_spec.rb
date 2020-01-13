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

  it 'can display the number of minors and majors on a flight' do
    airline = create :airline
    flight = create(:flight, airline_id: airline.id)
    passengers_minor = create_list(:passenger, 40, age: 16)
    passengers_major = create_list(:passenger, 60, age: 21)
    flight.passengers << passengers_minor
    flight.passengers << passengers_major

    visit "/flights/#{flight.id}"

    within '#major-passengers-count' do
      expect(page).to have_content("Number of adult passengers on flight: 60")
    end
    within '#minor-passengers-count' do
      expect(page).to have_content("Number of minor passengers on flight: 40")
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
