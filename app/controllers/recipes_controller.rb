class RecipesController < ApplicationController
  layout 'standard'
  before_action :authenticate_user!
 
  def index
    @user = current_user
    @recipes = @user.recipes
  end

  def new 
    @recipe = Recipe.new
    @foods = current_user.foods

  end

  def create 
     @recipe = Recipe.new(recipe_params.except(:food_quantities))
     @recipe.user = current_user
   
    if @recipe.save
      food_quantities = recipe_params[:food_quantities]
      if food_quantities
        food_quantities.each do |food_id, quantity|
          # Process each food quantity as needed
          @recipe.recipe_foods.create(food_id: food_id, quantity: quantity.to_i, recipe_id: @recipe.id) unless quantity.to_i < 1 
        end
      end
      redirect_to recipes_path
    else
      render :new
    end
  end

  def show 
    @recipe = Recipe.find(params[:id])
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    #destroy all recipe_foods
    @recipe.recipe_foods.destroy_all if @recipe.recipe_foods

    @recipe.destroy
     redirect_to recipes_path
  end

  private 
  
  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, food_quantities: {})
  end
  
  def food_quantities_params
    params.require(:recipe).permit(food_quantities: {})
  end

end