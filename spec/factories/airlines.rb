FactoryBot.define do
  factory :airline do
    name { Faker::Space.unique.moon + random_airline_suffix }
  end
end

def random_airline_suffix
  rand_nr = rand
  if rand_nr < 0.33
    " Airlines"
  elsif rand_nr < 0.66
    " Airways"
  else
    " Aviation Group"
  end
end
