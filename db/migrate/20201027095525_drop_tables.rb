class DropTables < ActiveRecord::Migration[6.0]
  def up
    drop_table :recipe_ingredients
    drop_table :recipes
    drop_table :refrigerator_ingredients
    drop_table :refrigerators
  end
  def down
    create_table :recipes do |t|
      t.references :user,     null: false, foreign_key: true
      t.string     :name,     null: false
      t.integer    :calorie
      t.integer    :time
      t.timestamps
    end
    create_table :recipe_ingredients do |t|
      t.references :recipe,            null: false, foreign_key: true
      t.integer    :ingredient_id,     null: false
      t.integer    :quantity,          null: false
      t.timestamps
    end
    create_table :refrigerators do |t|
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
    create_table :refrigerator_ingredients do |t|
      t.references :refrigerator,      null: false, foreign_key: true
      t.integer    :ingredient_id,     null: false
      t.integer    :quantity,          null: false
      t.date       :limit,             null: false
      t.timestamps
    end
  end
end
