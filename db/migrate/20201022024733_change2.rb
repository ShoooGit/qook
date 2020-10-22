class Change2 < ActiveRecord::Migration[6.0]
  def change
    remove_column :refrigerator_ingredients, :ingredient_id, :integer
    remove_column :recipe_ingredients, :ingredient_id, :integer

    add_column :refrigerator_ingredients, :ingredient_id, :integer, null: false, after: :refrigerator_id
    add_index :refrigerator_ingredients, :ingredient_id, unique: true
    add_column :recipe_ingredients, :ingredient_id, :integer, null: false, after: :recipe_id
    add_index :recipe_ingredients, :ingredient_id, unique: true
  end
end
