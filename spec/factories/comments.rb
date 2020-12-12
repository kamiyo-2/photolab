FactoryBot.define do
  factory :comment do
    text                  {"コメント"}
    association :user  
    association :post
  end
end
