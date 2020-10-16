require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before do
    @recipe = FactoryBot.build(:recipe)
  end

  describe 'レシピ登録' do
    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@recipe).to be_valid
    end
    it 'calorieが空白でも登録できること' do
      @recipe.calorie = nil
      expect(@recipe).to be_valid
    end
    it 'timeが空白でも登録できること' do
      @recipe.time = nil
      expect(@recipe).to be_valid
    end
    it 'ユーザーが紐付いていなければ登録できないこと' do
      @recipe.user = nil
      @recipe.valid?
      expect(@recipe.errors.full_messages).to include('ユーザーを入力してください')
    end
    it '画像の添付がなければ保存できないこと' do
      @recipe.image = nil
      @recipe.valid?
      expect(@recipe.errors.full_messages).to include('料理の写真を選択してください')
    end
    it 'nameが空だと登録できないこと' do
      @recipe.name = ''
      @recipe.valid?
      expect(@recipe.errors.full_messages).to include('レシピ名を入力してください')
    end
    it 'calorieが数字でないと登録できないこと' do
      @recipe.calorie = 'カロリー'
      @recipe.valid?
      expect(@recipe.errors.full_messages).to include('カロリーは数値で入力してください')
    end
    it 'calorieが1~9999でないと登録できないこと' do
      @recipe.calorie = '0'
      @recipe.valid?
      expect(@recipe.errors.full_messages).to include('カロリーは1以上の値にしてください')
    end
    it 'calorieが1~9999でないと登録できないこと' do
      @recipe.calorie = '10000'
      @recipe.valid?
      expect(@recipe.errors.full_messages).to include('カロリーは9999以下の値にしてください')
    end
    it 'timeが数字でないと登録できないこと' do
      @recipe.time = '調理時間'
      @recipe.valid?
      expect(@recipe.errors.full_messages).to include('調理時間は数値で入力してください')
    end
    it 'timeが1~9999でないと登録できないこと' do
      @recipe.time = '0'
      @recipe.valid?
      expect(@recipe.errors.full_messages).to include('調理時間は1以上の値にしてください')
    end
    it 'timeが1~9999でないと登録できないこと' do
      @recipe.time = '10000'
      @recipe.valid?
      expect(@recipe.errors.full_messages).to include('調理時間は9999以下の値にしてください')
    end
  end
end
