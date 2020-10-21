class RefrigeratorsController < ApplicationController
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

  private

  def refrigerator_params
    params.require(:refrigerator)
          .permit(refrigerator_ingredients_attributes: [:id, :ingredient_id, :quantity, :_destroy])
          .merge(user_id: current_user.id)
  end
end
