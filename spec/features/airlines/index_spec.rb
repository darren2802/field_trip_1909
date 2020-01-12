require 'rails_helper'

RSpec.describe "Airline Index Spec" do
  describe "When I visit the airline index page" do
    it 'I can see all airline names listed as links to their show page' do
      airlines = create_list(:airline, 10)

      visit '/airlines'

      airlines.each do |airline|
        within "#airline-#{airline.id}" do
          expect(page).to have_link(airline.name)
        end
      end

      within "#airline-#{airlines.last.id}" do
        click_link airlines.last.name
      end

      expect(current_path).to eq("/airlines/#{airlines.last.id}")
    end
  end
end
