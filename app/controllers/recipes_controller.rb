class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: [:show, :edit, :update]
  before_action :move_to_top, only: [:show, :edit]
  before_action :set_ingredients, only: [:show, :execute]
  before_action :check_exec, only: [:show, :execute]

  def index
    @recipes = Recipe.includes(:user).where(user_id: current_user.id).page(params[:page]).per(6)
  end

  def new
    @recipe = Recipe.new
    @recipe_ingredients = @recipe.recipe_ingredients.build
  end

  def show
  end

  def create
    @recipe = Recipe.new(recipe_params)
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
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe.id), notice: "#{@recipe.name}のレシピを編集しました"
    else
      render action: :edit
    end
  rescue ActiveRecord::RecordNotUnique
    flash.now[:alert] = '重複する食材があります'
    render action: :edit
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
    if RecipesHelper.execute(@target_ary)
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

  def set_ingredients
    # レシピに必要な食材を配列で取得
    @recipe_ingredients = RecipeIngredient.where(recipe_id: params[:id])

    # ユーザーに紐付く冷蔵庫が存在しなければ、リターン
    return unless Refrigerator.exists?(user_id: current_user.id)

    # ログインしているユーザーの冷蔵庫の食材を配列で取得
    @refrigerator_ingredients = RefrigeratorIngredient.where(refrigerator_id: current_user.refrigerator.id)
  end

  def check_exec
    # 冷蔵庫が空だった場合、FALSEを返す
    return @flg = FALSE if @refrigerator_ingredients.blank?

    # 対象の食材を格納する配列を宣言
    @target_ary = []

    # フラグの初期化
    @flg = TRUE

    # レシピに必要な食材と冷蔵庫の食材を突き合わせるループ
    @recipe_ingredients.each do |recipe_ingredient|
      @refrigerator_ingredients.each do |refrigerator_ingredient|
        # レシピに必要な食材と冷蔵庫の食材の突き合わせ
        if recipe_ingredient.ingredient_id == refrigerator_ingredient.ingredient_id

          # レシピに必要な食材が冷蔵庫に足りていない場合は、調理不可とする
          return @flg = FALSE unless recipe_ingredient.quantity <= refrigerator_ingredient.quantity

          # 対象の食材を格納して、フラグをTRUEに更新後、ループを抜ける
          @target_ary.push([recipe_ingredient, refrigerator_ingredient])
          @flg = TRUE
          break
        else
          @flg = FALSE
        end
      end
    end
  end
end
