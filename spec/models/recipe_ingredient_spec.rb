require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  before do
    @recipe_ingredient = FactoryBot.build(:recipe_ingredient)
  end

  describe 'レシピの食材登録' do
    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@recipe_ingredient).to be_valid
    end
    it 'recipe_idとingredient_idの両方が重複しなければ保存できること' do
      FactoryBot.create(:recipe_ingredient)
      expect(@recipe_ingredient).to be_valid
    end
    it 'レシピが紐付いていなければ登録できないこと' do
      @recipe_ingredient.recipe = nil
      @recipe_ingredient.valid?
      expect(@recipe_ingredient.errors.full_messages).to include('レシピ名を入力してください')
    end
    it 'ingredient_idが空(0)では保存できないこと' do
      @recipe_ingredient.ingredient_id = 0
      @recipe_ingredient.valid?
      expect(@recipe_ingredient.errors.full_messages).to include('食材を選択してください')
    end
    it 'ingredient_idが空(nil)では保存できないこと' do
      @recipe_ingredient.ingredient_id = nil
      @recipe_ingredient.valid?
      expect(@recipe_ingredient.errors.full_messages).to include('食材を入力してください')
    end
    it 'recipe_idとingredient_idの両方が重複すると保存できないこと' do
      @recipe_ingredient2 = FactoryBot.create(:recipe_ingredient)
      @recipe_ingredient.recipe_id = @recipe_ingredient2.recipe_id
      @recipe_ingredient.valid?
      expect(@recipe_ingredient.errors.full_messages).to include('食材はすでに存在します')
    end
    it 'quantityが空だと登録できないこと' do
      @recipe_ingredient.quantity = nil
      @recipe_ingredient.valid?
      expect(@recipe_ingredient.errors.full_messages).to include('食材の単位を入力してください')
    end
    it 'quantityが数字でないと登録できないこと' do
      @recipe_ingredient.quantity = '食材の単位'
      @recipe_ingredient.valid?
      expect(@recipe_ingredient.errors.full_messages).to include('食材の単位は数値で入力してください')
    end
    it 'quantityが1~1000でないと登録できないこと' do
      @recipe_ingredient.quantity = '0'
      @recipe_ingredient.valid?
      expect(@recipe_ingredient.errors.full_messages).to include('食材の単位は0.1以上の値にしてください')
    end
    it 'quantityが1~1000でないと登録できないこと' do
      @recipe_ingredient.quantity = '1001'
      @recipe_ingredient.valid?
      expect(@recipe_ingredient.errors.full_messages).to include('食材の単位は1000以下の値にしてください')
    end
  end
end
