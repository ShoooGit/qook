require 'rails_helper'

RSpec.describe RefrigeratorIngredient, type: :model do
  before do
    @refrigerator_ingredient = FactoryBot.build(:refrigerator_ingredient)
  end

  describe '冷蔵庫の食材登録' do
    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@refrigerator_ingredient).to be_valid
    end
    it 'refrigerator_idとingredient_idの両方が重複しなければ保存できること' do
      FactoryBot.create(:refrigerator_ingredient)
      expect(@refrigerator_ingredient).to be_valid
    end
    it '冷蔵庫が紐付いていなければ登録できないこと' do
      @refrigerator_ingredient.refrigerator = nil
      @refrigerator_ingredient.valid?
      expect(@refrigerator_ingredient.errors.full_messages).to include('冷蔵庫を入力してください')
    end
    it 'ingredient_idが空(0)では保存できないこと' do
      @refrigerator_ingredient.ingredient_id = 0
      @refrigerator_ingredient.valid?
      expect(@refrigerator_ingredient.errors.full_messages).to include('食材を選択してください')
    end
    it 'ingredient_idが空(nil)では保存できないこと' do
      @refrigerator_ingredient.ingredient_id = nil
      @refrigerator_ingredient.valid?
      expect(@refrigerator_ingredient.errors.full_messages).to include('食材を入力してください')
    end
    it 'refrigerator_idとingredient_idの両方が重複すると保存できないこと' do
      @refrigerator_ingredient2 = FactoryBot.create(:refrigerator_ingredient)
      @refrigerator_ingredient.refrigerator_id = @refrigerator_ingredient2.refrigerator_id
      @refrigerator_ingredient.valid?
      expect(@refrigerator_ingredient.errors.full_messages).to include('食材はすでに存在します')
    end
    it 'quantityが空だと登録できないこと' do
      @refrigerator_ingredient.quantity = nil
      @refrigerator_ingredient.valid?
      expect(@refrigerator_ingredient.errors.full_messages).to include('食材の単位を入力してください')
    end
    it 'quantityが数字でないと登録できないこと' do
      @refrigerator_ingredient.quantity = '食材の単位'
      @refrigerator_ingredient.valid?
      expect(@refrigerator_ingredient.errors.full_messages).to include('食材の単位は数値で入力してください')
    end
    it 'quantityが1~1000でないと登録できないこと' do
      @refrigerator_ingredient.quantity = '0'
      @refrigerator_ingredient.valid?
      expect(@refrigerator_ingredient.errors.full_messages).to include('食材の単位は0.1以上の値にしてください')
    end
    it 'quantityが1~1000でないと登録できないこと' do
      @refrigerator_ingredient.quantity = '1001'
      @refrigerator_ingredient.valid?
      expect(@refrigerator_ingredient.errors.full_messages).to include('食材の単位は1000以下の値にしてください')
    end
  end
end
