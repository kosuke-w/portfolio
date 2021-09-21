FactoryBot.define do
  factory :registered_item do
    association :item
    association :coordinate
  end
end
