class AddColumnCookingToRecipe < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :cook_flg, :boolean, null: false, after: :time
  end
end
