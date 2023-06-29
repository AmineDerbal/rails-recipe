require 'rails_helper'

RSpec.feature 'foods visit index', type: :feature do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @user = User.create(email: 'user@example.com', password: 'password', name: 'user')
    @user.confirm
    @food = Food.create(name: 'My food', measurement_unit: 'test', price: 10, quantity: 10, user: @user)
    sign_in @user
    visit foods_path
  end

  it 'shows the header title' do
    expect(page).to have_content('Foods')
  end

  it 'shows the food details' do
    expect(page).to have_content(@food.name)
    expect(page).to have_content(@food.measurement_unit)
    expect(page).to have_content(@food.price)
    expect(page).to have_content(@food.quantity)
    expect(page).to have_button('Delete')
    expect(page).to have_link('Show')
  end
  it 'delete the food' do
    click_button 'Delete'
    expect(page).to have_current_path(foods_path)
    expect(page).not_to have_content(@food.name)
    expect(page).not_to have_content(@food.measurement_unit)
    expect(page).not_to have_content(@food.price)
    expect(page).not_to have_content(@food.quantity)
    expect(page).not_to have_button('Delete')
    expect(page).not_to have_button('Modify')
  end
end
