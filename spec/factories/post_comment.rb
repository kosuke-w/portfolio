FactoryBot.define do
  factory :post_comment do
    comment { Faker::Lorem.characters(number: 30) }
    association :user
    association :post
  end
end
