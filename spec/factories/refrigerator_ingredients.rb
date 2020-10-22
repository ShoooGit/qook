FactoryBot.define do
  factory :refrigerator_ingredient do
    ingredient_id     { '629' }
    quantity          { '1' }
    association :refrigerator
  end
end
