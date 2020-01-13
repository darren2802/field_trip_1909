require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe 'validations' do
    it {should validate_presence_of :number}
    it {should validate_presence_of :date}
    it {should validate_presence_of :time}
    it {should validate_presence_of :departure_city}
    it {should validate_presence_of :arrival_city}
  end
  describe 'relationships' do
    it {should belong_to :airline}
    it { should have_many :passenger_flights }
  end

  describe 'methods' do
    it 'can display the number of adult or minor passengers on a flight' do
      airline = FactoryBot.create :airline
      flight = FactoryBot.create(:flight, airline_id: airline.id)
      passengers_minor = FactoryBot.create_list(:passenger, 40, age: 16)
      passengers_major = FactoryBot.create_list(:passenger, 60, age: 21)
      flight.passengers << passengers_minor
      flight.passengers << passengers_major

      expect(flight.count_maj_passenger).to eq(60)
      expect(flight.count_min_passenger).to eq(40)
    end
  end
end
