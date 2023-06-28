class RecipeFoodsController < ApplicationController


  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    if recipe_food_params[:quantity].blank?
      redirect_to new_recipe_recipe_food_path(@recipe), alert: 'Quantity is required.'
      return
    end

    existing_recipe_food = @recipe.recipe_foods.find_by(food_id: recipe_food_params[:food_id])

    if existing_recipe_food
      existing_recipe_food.update(quantity: recipe_food_params[:quantity])
      redirect_to recipe_path(@recipe), notice: 'Recipe_food quantity updated successfully.'
      return
    end

    @recipe_foods = @recipe.recipe_foods.new(recipe_food_params)
    if @recipe_foods.save
      redirect_to recipe_path(@recipe), notice: 'Recipe_food is successfully Created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy
    redirect_to recipe_path(@recipe), notice: 'Recipe_food is successfully deleted.'
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end
end
