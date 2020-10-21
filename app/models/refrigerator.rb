class Refrigerator < ApplicationRecord
  # アソシエーションの設定
  belongs_to :user
  has_many :refrigerator_ingredients, dependent: :destroy
  accepts_nested_attributes_for :refrigerator_ingredients
end
