class RemoveLimitFromRefrigeratorIngredients < ActiveRecord::Migration[6.0]
  def change
    remove_column :refrigerator_ingredients, :limit, :date
  end
end
