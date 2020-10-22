class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: [:show, :edit, :update]
  before_action :move_to_top, only: :edit

  def index
    @recipes = Recipe.includes(:user).where(user_id: current_user.id)
  end

  def new
    @recipe = Recipe.new
    @recipe_ingredients = @recipe.recipe_ingredients.build
  end

  def show
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
      redirect_to recipe_path(@recipe.id)
    else
      render action: :edit
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    if recipe.destroy
      redirect_to root_path
    else
      render action: :show
    end
  end

  def execute
    # レシピに必要な食材を配列で取得
    @recipe_ingredients = RecipeIngredient.where(recipe_id: params[:id])
    # ログインしているユーザーの冷蔵庫の食材を配列で取得
    @refrigerator_ingredients = RefrigeratorIngredient.where(refrigerator_id: current_user.refrigerator.id)

    # レシピに必要な食材と冷蔵庫の食材を突き合わせるループ
    @recipe_ingredients.each do |recipe_ingredient|
      @refrigerator_ingredients.each_with_index do |refrigerator_ingredient, i|
        # レシピに必要な食材と冷蔵庫の食材の突き合わせ
        next unless recipe_ingredient.ingredient_id == refrigerator_ingredient.ingredient_id

        # 冷蔵庫の食材をレシピに必要な食材数分減らす
        quantity = @refrigerator_ingredients[i].quantity -= recipe_ingredient.quantity

        # 冷蔵庫の食材数に応じて処理を分岐
        if quantity.zero?
          # 食材がなくなったらレコードを削除
          render action: :show unless @refrigerator_ingredients[i].delete
        else
          # 減らした食材を更新
          render action: :show unless @refrigerator_ingredients[i].update(quantity: quantity)
        end
      end
    end
    redirect_to root_path
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

  def move_to_top
    # 別ユーザのレシピ編集画面にアクセスした場合、トップページにリダイレクト
    redirect_to root_path if current_user.id != @recipe.user_id
  end
end
