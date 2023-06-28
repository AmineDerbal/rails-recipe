require 'rails_helper'

RSpec.describe 'public recipes Index', type: :request do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @user1 = User.create(email: 'user@example.com', password: 'password', name: 'user')
    @user1.confirm
    sign_in @user1
    @user2 = User.create(email: 'user2@example.com', password: 'password', name: 'user2')
    @user3 = User.create(email: 'user3@example.com', password: 'password', name: 'user3')
    @recipe1 = Recipe.create(name: 'My first recipe', preparation_time: 10, cooking_time: 10, description: 'test',
                             public: false, user: @user3)
    @recipe2 = Recipe.create(name: 'My second recipe', preparation_time: 10, cooking_time: 10, description: 'test',
                             public: true, user: @user2)
    @recipe3 = Recipe.create(name: 'My third recipe', preparation_time: 10, cooking_time: 10, description: 'test',
                             public: true, user: @user1)
    get '/public_recipes'
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

  it 'include the list of all public recipes' do
    expect(response.body).to include('List of all public recipes')
  end
end
