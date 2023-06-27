class UsersController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def show
    puts 'show'
    if params[:id] == 'sign_out'
      sign_out(current_user)
      redirect_to root_path, notice: 'You have been signed out successfully.'
    else
      redirect_to root_path
    end
  end
end
