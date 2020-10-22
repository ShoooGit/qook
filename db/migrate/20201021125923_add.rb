class Add < ActiveRecord::Migration[6.0]
  def change
    add_column :refrigerator_ingredients, :ingredient_id, :integer, null: false
    add_index :refrigerator_ingredients, :ingredient_id, unique: true
    add_column :recipe_ingredients, :ingredient_id, :integer, null: false
    add_index :recipe_ingredients, :ingredient_id, unique: true
  end
end
