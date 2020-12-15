FactoryBot.define do
  factory :comment do
    text                  {Faker::String.random(length: 4)}
    association :user  
    association :post
  end
end
