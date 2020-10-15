class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.references :user,     null: false, foreign_key: true
      t.string     :name,     null: false
      t.integer    :calorie
      t.integer    :time
      t.timestamps
    end
  end
end
