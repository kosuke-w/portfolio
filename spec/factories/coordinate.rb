FactoryBot.define do
  factory :coordinate do
    comment { Faker::Lorem.characters(number:20) }
    season { Faker::Number.betweea(from: 0, to: 3) }
  end
end