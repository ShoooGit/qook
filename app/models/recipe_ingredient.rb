class RecipeIngredient < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # アソシエーションの設定
  belongs_to :recipe
  belongs_to_active_hash :ingredient

  # バリデーションの設定

  # 空白でないこと
  with_options presence: true do
    # セレクトボックスの選択が「---」の時は保存できないようにする
    validates :ingredient_id, numericality: { other_than: 0, message: 'を選択してください' }, uniqueness: true
    # 1 ~ 1000
    validates :quantity, numericality: {
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 1_000
    }
  end
end
