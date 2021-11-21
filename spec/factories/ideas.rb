FactoryBot.define do
  factory :idea do
    title  { Faker::Name.name }
    memo   { Faker::Music::Hiphop.artist  }
    association :user
  end
end