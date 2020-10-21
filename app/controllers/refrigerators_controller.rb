class RefrigeratorsController < ApplicationController
  before_action :set_refrigerator, only: [:edit, :update]

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
end
