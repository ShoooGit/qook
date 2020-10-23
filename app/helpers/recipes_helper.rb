module RecipesHelper
  def self.search(user_id, search)
    if search != ''
      Recipe.where('user_id = ? and name LIKE(?)', user_id, "%#{search}%")
    else
      Recipe.includes(:user).where(user_id: user_id)
    end
  end

  def self.execute(targets)
    targets.each do |target|
      quantity = target[1].quantity - target[0].quantity
      # 冷蔵庫の食材数に応じて処理を分岐
      if quantity.zero?
        # 食材がなくなったらレコードを削除
        return FALSE unless target[1].delete
      else
        # 減らした食材を更新
        return FALSE unless target[1].update(quantity: quantity)
      end
    end
  end
end
