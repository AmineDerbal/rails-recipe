class GeneralShoppingListController < ApplicationController
  def index
    @user = current_user
    @recipes = @user.recipes.includes(:recipe_foods) # Eager load recipe_foods association
    @foods = @user.foods
    @missing_foods = []

    @foods.each do |food|
      total_quantity = @recipes.sum { |recipe| recipe.recipe_foods.where(food_id: food.id).sum(:quantity) }
      next unless food.quantity < total_quantity

      missing_quantity = total_quantity - food.quantity
      @missing_foods << {
        name: food.name,
        quantity: missing_quantity,
        price: food.price
      }
    end

    @total_price = 0
  end
end