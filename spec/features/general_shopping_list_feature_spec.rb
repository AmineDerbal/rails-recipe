require 'rails_helper'

RSpec.feature 'general shopping list visit index', type: :feature do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @user = User.create(email: 'user@example.com', password: 'password', name: 'user')
    @user.confirm
    sign_in @user
    @food = Food.create(name: 'My food', measurement_unit: 'test', price: 10, quantity: 10, user: @user)
    @recipe = Recipe.create(name: 'My recipe', preparation_time: 10, cooking_time: 10, description: 'My description',
                            public: true, user: @user)
    @recipe_foods = @recipe.recipe_foods.create(food_id: @food.id, quantity: 12, recipe_id: @recipe.id)
    visit general_shopping_list_index_path
  end

  it 'shows the header title' do
    expect(page).to have_content('General Shopping List')
  end
  it 'shows the food details' do
    expect(page).to have_content('Total Missing Food Items: 1')
    expect(page).to have_content('Total Price of Missing Food: 20.0')
    expect(page).to have_content(@food.name)
    expect(page).to have_content(@recipe_foods.quantity - @food.quantity)
    expect(page).to have_content((@recipe_foods.quantity - @food.quantity) * @food.price)
  end
end
