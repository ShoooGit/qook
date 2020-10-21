class RefrigeratorsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_refrigerator, only: [:edit, :update]
  before_action :move_to_top_new, only: :new
  before_action :move_to_top_edit, only: :edit

  def new
    @refrigerator = Refrigerator.new
  end

  def create
    @refrigerator = Refrigerator.new(refrigerator_params)
    if @refrigerator.save
      redirect_to root_path
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    if @refrigerator.update(refrigerator_params)
      redirect_to root_path
    else
      render action: :edit
    end
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
