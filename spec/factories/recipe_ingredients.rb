FactoryBot.define do
  factory :recipe_ingredient do
    ingredient_id     { '629' }
    quantity          { '1' }
    association :recipe
  end
end
