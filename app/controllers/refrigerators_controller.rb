class RefrigeratorsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_refrigerator, only: [:edit, :update]
  before_action :move_to_top_new, only: :new
  before_action :move_to_top_edit, only: :edit

  def new
    @refrigerator = Refrigerator.new
    @refrigerator_ingredients = @refrigerator.refrigerator_ingredients.build
  end

  def create
    @refrigerator = Refrigerator.new(refrigerator_params)
    begin
      if @refrigerator.save
        # 冷蔵庫を作成したら、全レシピの調理可否フラグを更新する
        @recipes = Recipe.includes(:user).where(user_id: current_user.id)
        @recipes.each do |recipe|
          RecipesHelper.update_flg(recipe, current_user)
        end
        redirect_to root_path, notice: '冷蔵庫を作成し、食材を追加しました'
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
    if @refrigerator.update(refrigerator_params)
      # 冷蔵庫の食材を更新したら、全レシピの調理可否フラグを更新する
      @recipes = Recipe.includes(:user).where(user_id: current_user.id)
      @recipes.each do |recipe|
        RecipesHelper.update_flg(recipe, current_user)
      end
      redirect_to root_path, notice: '冷蔵庫の内容を更新しました'
    else
      render action: :edit
    end
  rescue ActiveRecord::RecordNotUnique
    flash.now[:alert] = '重複する食材があります'
    render action: :edit
  end

  private

  def refrigerator_params
    params.require(:refrigerator)
          .permit(refrigerator_ingredients_attributes: [:id, :ingredient_id, :quantity, :_destroy])
          .merge(user_id: current_user.id)
  end

  def set_refrigerator
    @refrigerator = Refrigerator.find(params[:id])
  end

  def move_to_top_new
    # すでに冷蔵庫の存在するユーザが冷蔵庫作成ページにアクセスした場合、トップページにリダイレクト
    redirect_to root_path if current_user.refrigerator
  end

  def move_to_top_edit
    # 別ユーザの冷蔵庫にアクセスした場合、トップページにリダイレクト
    redirect_to root_path if current_user.id != @refrigerator.user_id
  end
end
