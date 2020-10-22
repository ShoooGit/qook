class ChangeIngredientIdFromRecipeIngredients < ActiveRecord::Migration[6.0]
  def change
    change_column :recipe_ingredients, :ingredient_id, :integer, unique: true
  end
end
