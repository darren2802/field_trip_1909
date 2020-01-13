require 'rails_helper'

RSpec.describe 'Passenger Show Page' do
  before :each do
    @airline = create(:airline)
    @flights = create_list(:flight, 20, airline_id: @airline.id)
    @passenger = create(:passenger)
    @passenger.flights << @flights
  end

  it 'can display the details for a passenger' do
    visit "/passengers/#{@passenger.id}"
    expect(current_path).to eq("/passengers/#{@passenger.id}")

    expect(page).to have_content(@passenger.name)

    @passenger.flights.each do |passenger_flight|
      within "#passenger-flight-#{passenger_flight.id}" do
        expect(page).to have_content(passenger_flight.number)
        click_link "#{passenger_flight.number}"
        expect(current_path).to eq("/flights/#{passenger_flight.number}")
        visit "/passengers/#{@passenger.id}"
      end
    end
  end
end

# User Story 2, Passenger Show Page

# As a visitor
# When I visit a passengers show page ('/passengers/:id')
# I see that passengers name
# And I see a section of the page that displays all flight numbers of the flights for that passenger
# And all flight numbers listed link to that flights show page
