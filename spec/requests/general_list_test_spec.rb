require 'rails_helper'

RSpec.describe 'general shopping list Index', type: :request do
  include Devise::Test::IntegrationHelpers

  describe 'Get /index' do
    before(:each) do
      @user = User.create(email: 'user@example.com', password: 'password', name: 'user')
      @user.confirm
      sign_in @user
      @food = Food.create(name: 'My food', measurement_unit: 'test', price: 10, quantity: 10, user: @user)
      @recipe = Recipe.create(name: 'My recipe', preparation_time: 10, cooking_time: 10, description: 'My description',
                              public: true, user: @user)
      @recipe.recipe_foods.create(food_id: @food.id, quantity: 12, recipe_id: @recipe.id)
      get '/general_shopping_list'
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'return 200' do
      expect(response.status).to eq(200)
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end

    it 'include the list of Foods' do
      expect(response.body).to include('General Shopping List')
    end
  end
end
