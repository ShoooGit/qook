class CreateRefrigeratorIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :refrigerator_ingredients do |t|
      t.references :refrigerator,      null: false, foreign_key: true
      t.integer    :ingredient_id,     null: false
      t.integer    :quantity,          null: false
      t.date       :limit,             null: false
      t.timestamps
    end
  end
end
