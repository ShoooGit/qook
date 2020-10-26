class ChangeIndexToRecipe < ActiveRecord::Migration[6.0]
  def change
    # 変更内容
    def up
      change_column :recipe_ingredients, :recipe, :references, foreign_key: false, null: false
      remove_index :recipe_ingredients, :ingredient_id
      add_index :recipe_ingredients, [:recipe_id, :ingredient_id], unique: true
    end

    # 変更前の状態
    def down
      change_column :recipe_ingredients, :recipe, :references, foreign_key: true, null: false
    end
  end
end
