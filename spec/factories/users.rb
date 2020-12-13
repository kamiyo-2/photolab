FactoryBot.define do
  factory :user do
    name                  {"test"}
    profile               {"profile"}
    email                 {"test@example"}
    password              {"000000"}
    password_confirmation {password}
  end
end