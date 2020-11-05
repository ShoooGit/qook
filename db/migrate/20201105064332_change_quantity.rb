class ChangeQuantity < ActiveRecord::Migration[6.0]
  def up
    change_column :recipe_ingredients, :quantity, :float
    change_column :refrigerator_ingredients, :quantity, :float
  end
  
  def down
    change_column :recipe_ingredients, :quantity, :integer
    change_column :refrigerator_ingredients, :quantity, :integer
  end
end
