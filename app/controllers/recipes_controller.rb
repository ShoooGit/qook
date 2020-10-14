class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def index
  end
  def new
    @recipe = Recipe.new
  end
end
