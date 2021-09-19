FactoryBot.define do
  factory :record do
    start_time { Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :all)}
    association :coordinate
  end
end