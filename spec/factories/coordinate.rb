FactoryBot.define do
  factory :coordinate do
    name { Faker::Lorem.characters(number: 10) }
    comment { Faker::Lorem.characters(number: 20) }
    season { Faker::Number.between(from: 0, to: 3) }

    association :user
  end
end
