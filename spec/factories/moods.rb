FactoryBot.define do
  factory :mood do
    association :user

    mood { [1, 2, 3, 4, 5].sample }
    description { Faker::Lorem.sentence }
  end
end
