module RecipesHelper
  def self.search(user_id, search, page)
    if search != ''
      Recipe.where('user_id = ? and name LIKE(?)', user_id, "%#{search}%").page(page).per(4)
    else
      Recipe.includes(:user).where(user_id: user_id).page(page).per(4)
    end
  end

  def self.execute(recipe_id, refrigerator_id)
    # レシピ食材のセット
    recipe_ingredients = RecipeIngredient.where(recipe_id: recipe_id)

    # 冷蔵庫食材のセット
    refrigerator_ingredients = RefrigeratorIngredient.where(refrigerator_id: refrigerator_id)

    # レシピに必要な食材と冷蔵庫の食材を突き合わせるループ
    recipe_ingredients.each do |recipe_ingredient|
      refrigerator_ingredients.each do |refrigerator_ingredient|
        # レシピに必要な食材と冷蔵庫の食材の突き合わせ
        next unless recipe_ingredient.ingredient_id == refrigerator_ingredient.ingredient_id

        # レシピに必要な食材が冷蔵庫に足りていない場合は、調理不可とする
        refrigerator_ingredient.quantity -= recipe_ingredient.quantity
        # 冷蔵庫の食材数に応じて処理を分岐
        if refrigerator_ingredient.quantity.zero?
          # 食材がなくなったらレコードを削除
          return FALSE unless refrigerator_ingredient.delete
        else
          # 減らした食材を更新
          return FALSE unless refrigerator_ingredient.update(quantity: refrigerator_ingredient.quantity)
        end
      end
    end
  end

  def self.check_cooking(recipe, current_user)
    # ユーザーに紐付く冷蔵庫が存在しなければ、リターン
    return false unless Refrigerator.exists?(user_id: current_user.id)

    # レシピ食材のセット
    recipe_ingredients = RecipeIngredient.where(recipe_id: recipe.id)

    # 冷蔵庫食材のセット
    refrigerator_ingredients = RefrigeratorIngredient.where(refrigerator_id: current_user.refrigerator.id)

    # 調理可否フラグの初期化
    flg = true

    # レシピに必要な食材と冷蔵庫の食材を突き合わせるループ
    recipe_ingredients.each do |recipe_ingredient|
      refrigerator_ingredients.each do |refrigerator_ingredient|
        # レシピに必要な食材と冷蔵庫の食材の突き合わせ
        if recipe_ingredient.ingredient_id == refrigerator_ingredient.ingredient_id
          # レシピに必要な食材が冷蔵庫に足りていない場合は、調理不可とする
          return false unless recipe_ingredient.quantity <= refrigerator_ingredient.quantity

          flg = true
          break
        else
          flg = false
        end
      end
      return flg if flg == false
    end

    flg
  end

  def self.update_flg(recipe, current_user)
    p check_cooking(recipe, current_user)
    recipe.update(cook_flg: check_cooking(recipe, current_user))
  end
end
