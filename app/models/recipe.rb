class Recipe < ApplicationRecord
  # アソシエーションの設定
  belongs_to :user
  has_many :recipe_ingredients, dependent: :destroy
  accepts_nested_attributes_for :recipe_ingredients
  has_one_attached :image

  # バリデーションの設定
  # 空白でないこと
  validates :name, presence: true
  validates :image, presence: { message: 'を選択してください' }
  # 0 ~ 9999
  with_options numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 9_999
  } do
    validates :calorie, allow_blank: true
    validates :time, allow_blank: true
  end
end
