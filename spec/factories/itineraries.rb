FactoryBot.define do
  factory :itinerary do
    sequence(:name) { |n| "Thailand #{n}" }

    user
  end
end
