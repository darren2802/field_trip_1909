require 'rails_helper'

RSpec.describe 'Passenger Show Page' do
  before :each do
    @airline = create(:airline)
    @flights = create_list(:flight, 20, airline_id: @airline.id)
    @passenger = create(:passenger)
    @passenger.flights << @flights
    @flight_to_assign = create(:flight, airline_id: @airline.id)
  end

  it 'can display the details for a passenger' do
    visit "/passengers/#{@passenger.id}"
    expect(current_path).to eq("/passengers/#{@passenger.id}")

    expect(page).to have_content(@passenger.name)

    @passenger.flights.each do |passenger_flight|
      within "#passenger-flight-#{passenger_flight.id}" do
        expect(page).to have_content(passenger_flight.number)
        click_link "#{passenger_flight.number}"
        expect(current_path).to eq("/flights/#{passenger_flight.id}")
        visit "/passengers/#{@passenger.id}"
      end
    end
  end

  it 'can assign a flight to a passenger by completing a form on the show page' do
    visit "/passengers/#{@passenger.id}"

    within '#assign-passenger-to-flight' do
      fill_in 'Flight number', with: @flight_to_assign.id
      click_button 'Assign Passenger to Flight'
    end

    expect(current_path).to eq("/passengers/#{@passenger.id}")

    within "#passenger-flight-#{@flight_to_assign.id}" do
      expect(page).to have_content(@flight_to_assign.number)
      click_link "#{@flight_to_assign.number}"
      expect(current_path).to eq("/flights/#{@flight_to_assign.id}")
      visit "/passengers/#{@passenger.id}"
    end
  end
end

# User Story 3, Assign a Passenger to a Flight
#
# As a visitor
# When I visit a passengers show page
# I see a form to add a flight
# When I fill in the form with a flight number (assuming these will always be unique)
# And click submit
# I'm taken back to the passengers show page
# And I can see the flight number of the flight I just added

# User Story 2, Passenger Show Page

# As a visitor
# When I visit a passengers show page ('/passengers/:id')
# I see that passengers name
# And I see a section of the page that displays all flight numbers of the flights for that passenger
# And all flight numbers listed link to that flights show page
