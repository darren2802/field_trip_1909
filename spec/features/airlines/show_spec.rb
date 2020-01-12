require 'rails_helper'

RSpec.describe "Airline Show Spec" do
  describe "When I visit the airline show page" do
    it 'I can see that airlines name and all its flights' do
      airline = create :airline

      10.times do
        airline.flights << create(:flight, airline_id: airline.id)
      end

      visit "/airlines/#{airline.id}"

      expect(page).to have_content(airline.name)

      airline.flights.each do |airline_flight|
        within "#flight-#{airline_flight.id}" do
          expect(page).to have_content("Flight Number: #{airline_flight.number}")
          expect(page).to have_content("Date: #{airline_flight.date}")
          expect(page).to have_content("Time: #{airline_flight.time}")
          expect(page).to have_content("Departure City: #{airline_flight.departure_city}")
          expect(page).to have_content("Arrival City: #{airline_flight.arrival_city}")
        end
      end
    end
  end
end
