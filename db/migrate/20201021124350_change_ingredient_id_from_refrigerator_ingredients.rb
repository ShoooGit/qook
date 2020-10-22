class ChangeIngredientIdFromRefrigeratorIngredients < ActiveRecord::Migration[6.0]
  def change
    change_column :refrigerator_ingredients, :ingredient_id, :integer, unique: true
  end
end
