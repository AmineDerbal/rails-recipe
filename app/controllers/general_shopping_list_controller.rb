class GeneralShoppingListController < ApplicationController
  def index
    @user = current_user
    @recipes = @user.recipes.includes(:foods) # Retrieve all recipes of the logged-in user with associated foods

    # Compare the list of food for all recipes with the general food list of the user
    general_foods = @user.foods
    @missing_foods = general_foods.reject { |food| @recipes.any? { |recipe| recipe.foods.include?(food) } }

    # Calculate the total food items and total price of the missing food
    @total_items = @missing_foods.size
    @total_price = @missing_foods.sum(&:price)
  end
end
