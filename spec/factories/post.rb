FactoryBot.define do
  factory :post do
    text { Faker::Lorem.characters(number:30) }
    title { Faker::Lorem.characters(number:10) }
    image { Faker::Avatar.image }
  end
end