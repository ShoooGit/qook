class Refrigerator < ApplicationRecord
  # アソシエーションの設定
  belongs_to :user
  has_many :refrigerator_ingredients, dependent: :delete_all
  accepts_nested_attributes_for :refrigerator_ingredients, allow_destroy: true
end
