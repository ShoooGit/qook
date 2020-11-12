class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: [:show, :edit, :update]
  before_action :move_to_top, only: [:show, :edit]

  def index
    @recipes = Recipe.includes(:user).where(user_id: current_user.id).where(cook_flg: TRUE).page(params[:page]).per(4)
  end

  def new
    @recipe = Recipe.new
    @recipe_ingredients = @recipe.recipe_ingredients.build
  end

  def show
  end

  def create
    @recipe = Recipe.new(recipe_params)
    # 調理可否フラグの設定
    @recipe.cook_flg = RecipesHelper.check_cooking(@recipe, current_user)
    begin
      if @recipe.save
        redirect_to root_path, notice: "#{@recipe.name}のレシピを登録しました"
      else
        render action: :new
      end
    rescue ActiveRecord::RecordNotUnique
      flash.now[:alert] = '重複する食材があります'
      render action: :new
    end
  end

  def edit
  end

  def update
    begin
      if @recipe.update(recipe_params)
        RecipesHelper.update_flg(@recipe, current_user)
        redirect_to recipe_path(@recipe.id), notice: "#{@recipe.name}のレシピを編集しました"
      else
        render action: :edit
      end
    rescue ActiveRecord::RecordNotUnique
      flash.now[:alert] = '重複する食材があります'
      render action: :edit
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    name = recipe.name
    if recipe.destroy
      redirect_to root_path, notice: "#{name}のレシピを削除しました"
    else
      render action: :show
    end
  end

  def execute
    if RecipesHelper.execute(params[:id], current_user.refrigerator.id)

      # 食材を消費したら、全レシピの調理可否フラグを更新する
      @recipes = Recipe.includes(:user).where(user_id: current_user.id)
      @recipes.each do |recipe|
        RecipesHelper.update_flg(recipe, current_user)
      end

      redirect_to root_path, notice: '調理を実行し、冷蔵庫内の食材を消費しました'
    else
      render action: :show
    end
  end

  def search
    @recipes = RecipesHelper.search(current_user.id, params[:keyword], params[:page])
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
