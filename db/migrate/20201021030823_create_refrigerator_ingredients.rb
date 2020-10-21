class CreateRefrigeratorIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :refrigerator_ingredients do |t|

      t.timestamps
    end
  end
end
