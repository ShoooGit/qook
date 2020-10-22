class Change < ActiveRecord::Migration[6.0]
  def change
    remove_column :refrigerator_ingredients, :ingredient_id, :integer
    remove_column :recipe_ingredients, :ingredient_id, :integer
  end
end
