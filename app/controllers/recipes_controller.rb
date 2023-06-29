class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @recipes = @user.recipes
  end

  def show
    @user = current_user
    @recipe = Recipe.includes(:foods).find(params[:id])
  end

  def new
    @recipe = Recipe.new
    @foods = current_user.foods
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: !@recipe.public)
    redirect_to @recipe, notice: 'Recipe public status updated.'
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    if @recipe.save
      redirect_to recipes_path
    else
      render :new
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    # destroy all recipe_foods
    @recipe.recipe_foods&.destroy_all

    @recipe.destroy
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
