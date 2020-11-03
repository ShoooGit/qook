class CreateTables < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.references :user,     null: false, foreign_key: true
      t.string     :name,     null: false
      t.integer    :calorie
      t.integer    :time
      t.timestamps
    end
    create_table :recipe_ingredients do |t|
      t.references :recipe,            null: false, foreign_key: true, index: false
      t.integer    :ingredient_id,     null: false
      t.integer    :quantity,          null: false
      t.timestamps
    end
    create_table :refrigerators do |t|
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
    create_table :refrigerator_ingredients do |t|
      t.references :refrigerator,      null: false, foreign_key: true, index: false
      t.integer    :ingredient_id,     null: false
      t.integer    :quantity,          null: false
      t.timestamps
    end

    add_index :recipe_ingredients, [:recipe_id, :ingredient_id], unique: true, name: 'index_recipe_id_and_ingredient_id'
    add_index :refrigerator_ingredients, [:refrigerator_id, :ingredient_id], unique: true, name: 'index_refrigerator_id_and_ingredient_id'

  end
end
