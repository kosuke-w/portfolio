FactoryBot.define do
  factory :post do
    text { Faker::Lorem.characters(number:30) }
    title { Faker::Lorem.characters(number:10) }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/test.png')) }
    association :user
  end
end