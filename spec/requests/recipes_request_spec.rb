require 'rails_helper'

RSpec.describe 'Recipes Index', type: :request do
  include Devise::Test::IntegrationHelpers

  describe 'Get /index' do
    before(:each) do
      @user = User.create(email: 'user@example.com', password: 'password', name: 'user')
      @user.confirm
      @recipe = Recipe.create(name: 'recipe', preparation_time: 10, cooking_time: 10, description: 'test',
                              public: false, user: @user)
      @food = Food.create(name: 'food', measurement_unit: 'test', price: 10, quantity: 10, user: @user)
      sign_in @user
      get '/recipes'
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

    it 'include the list of recipe of the user' do
      expect(response.body).to include("List of all recipes of #{@user.name}")
    end
  end

  describe 'Get /show' do
    before(:each) do
      @user = User.create(email: 'user@example.com', password: 'password', name: 'user')
      @user.confirm
      @recipe = Recipe.create(name: 'recipe', preparation_time: 10, cooking_time: 10, description: 'test',
                              public: false, user: @user)
      @food = Food.create(name: 'food', measurement_unit: 'test', price: 10, quantity: 10, user: @user)
      sign_in @user
      get "/recipes/#{@recipe.id}"
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'return 200' do
      expect(response.status).to eq(200)
    end
    it 'renders the show template' do
      expect(response).to render_template('show')
    end

    it 'include the name of the recipe' do
      expect(response.body).to include(@recipe.name)
    end
  end
end
