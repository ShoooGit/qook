class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def index
  end

  def new
    @recipe = Recipe.new
    @recipe_ingredients = @recipe.recipe_ingredients.build
  end
end
