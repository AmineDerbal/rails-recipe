require 'rails_helper'

RSpec.describe 'Recipes Index', type: :request do
  include Devise::Test::IntegrationHelpers

  describe 'Get /index' do
    before(:each) do
      @user = User.create(email: 'user@example.com', password: 'password', name: 'user')
      @user.confirm
      @food = Food.create(name: 'My food', measurement_unit: 'test', price: 10, quantity: 10, user: @user)
      sign_in @user
      get '/foods'
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
      expect(response.body).to include('Foods')
    end
  end
end
