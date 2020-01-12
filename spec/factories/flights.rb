FactoryBot.define do
  factory :flight do
    number { Faker::Number.hexadecimal(digits: 3).upcase }
    date { Faker::Date.backward(days: 60) }
    time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now).strftime("%H:%M") }
    departure_city { Faker::Address.city }
    arrival_city { Faker::Address.city }
  end
end
