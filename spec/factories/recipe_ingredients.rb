FactoryBot.define do
  factory :recipe_ingredient do
    ingredient_id     { '1' }
    quantity          { '1' }

    association :recipe
  end
end
