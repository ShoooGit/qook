class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :edit, :update]
  before_action :set_recipe, only: [:edit, :update]

  def index
    @recipes = Recipe.includes(:user)
  end

  def new
    @recipe = Recipe.new
    @recipe_ingredients = @recipe.recipe_ingredients.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to root_path
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      # 以下はshow画面に行くようにあとから修正する
      redirect_to root_path
    else
      render action: :edit
    end
  end

  private

  def recipe_params
    params.require(:recipe)
          .permit(:name, :calorie, :time, :image, recipe_ingredients_attributes: [:id, :ingredient_id, :quantity, :_destroy])
          .merge(user_id: current_user.id)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
