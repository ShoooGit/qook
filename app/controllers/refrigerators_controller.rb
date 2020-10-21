class RefrigeratorsController < ApplicationController
  def show
    if Refrigerator.exists?(user_id: params[:id])
      @refrigerator = Refrigerator.find(user_id: params[:id])
    else
      @refrigerator = Refrigerator.new(user_id: current_user.id)
    end
  end
end
