class GeneralShoppingListController < ApplicationController
  def index
    @user = current_user
    @recipes = @user.recipes # Retrieve all recipes of the logged-in user with associated foods
    @foods = @user.foods # Retrieve all foods of the logged-in user
    @missing_foods = []

    @foods.each do |food|
      total_quantity = 0
      @recipes.each do |recipe|
        recipe_foods = recipe.recipe_foods.where(food_id: food.id)
        total_quantity += recipe_foods.sum(:quantity) if recipe_foods.exists?
      end
      next unless food.quantity < total_quantity

      missing_quantity = total_quantity - food.quantity
      @missing_food = {
        name: food.name,
        quantity: missing_quantity,
        price: food.price
      }
      @missing_foods << @missing_food
    end

    @total_price = 0
  end
end
