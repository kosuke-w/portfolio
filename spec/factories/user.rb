FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    image { File.open("#{Rails.root}/app/assets/images/test.png") }
    sex { Faker::Number.between(from: 0, to: 1) }
    address { Faker::Number.between(from: 1, to: 47) }
    introduction { Faker::Lorem.characters(number:30) }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
  end
end