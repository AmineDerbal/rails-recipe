class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    return unless user.present? # additional permissions for logged in users

    can(:read, Recipe, user:)
    can(:read, Food, user:)
    can(:read, RecipeFood, user:)
    can :destroy, Recipe, user_id: user.id
    can :destroy, Food, user_id: user.id
    can :destroy, RecipeFood, user_id: user.id
  end
end
