FactoryBot.define do
  factory :user do
    nickname              { 'test' }
    email                 { 'email@com' }
    password              { '123abc' }
    password_confirmation { password }
  end
end
