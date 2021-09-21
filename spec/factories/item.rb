FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    image { File.open("#{Rails.root}/app/assets/images/test.png") }
    genre { Faker::Number.between(from: 0, to: 5) }
    color { Faker::Number.between(from: 0, to: 9) }
    price { Faker::Number.number(digits: 5) }
    brand { Faker::Lorem.characters(number: 5) }
    caption { Faker::Lorem.characters(number: 10) }

    association :user
  end
end
