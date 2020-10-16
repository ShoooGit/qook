FactoryBot.define do
  factory :recipe do
    name              { 'カレーライス' }
    calorie           { '100' }
    time              { '60' }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test.jpg'), filename: 'test.jpg')
    end
  end
end
