Rails.application.routes.draw do
  get 'home/index'
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Add the following route for signing out
  resources :users, only: [:show]

  resources :foods # Add this line to generate the necessary routes for FoodsController

  resources :recipes, except: [:update] do
    resources :recipe_foods, only: [:new, :create, :destroy]
  end
  resources :public_recipes, except: [:update]
  resources :recipes do
    patch 'toggle_public', on: :member
  end
  resources :general_shopping_list, only: [:index]

  # Defines the root path route ("/")
  root "home#index" # Set the home page route to the "index" action of the "home" controller
end
