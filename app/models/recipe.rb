class Recipe < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :recipe_foods, class_name: 'RecipeFood', foreign_key: 'recipe_id'
  has_many :foods, through: :recipe_foods

  accepts_nested_attributes_for :recipe_foods

  validates :name, presence: true
  validates :preparation_time, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :cooking_time, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: true
end
