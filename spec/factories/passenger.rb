FactoryBot.define do
  factory :passenger do
    name { Faker::Name.name }
    age { Faker::Number.between(from: 1, to: 100) }
  end
end
