class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new]
  def index
  end

  def new
    @recipe = Recipe.new
    @recipe_ingredients = @recipe.recipe_ingredients.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.save
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :calorie, :time, :image,
      recipe_ingredients_attributes: [:id, :ingredient_id, :quantity, :_destroy]
    ).merge(user_id: current_user.id)
  end

end
