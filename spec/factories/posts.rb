FactoryBot.define do
  factory :post do
    text                  {"テキスト"}
    association :user             
    
  end
end
