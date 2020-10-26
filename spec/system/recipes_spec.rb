require 'rails_helper'

RSpec.describe 'レシピ登録', type: :system do
  before do
    @recipe_ingredient = FactoryBot.build(:recipe_ingredient)
    @recipe = @recipe_ingredient.recipe
    @user = @recipe.user
    @user.save
  end
  context 'レシピ登録ができるとき'do
    it 'ログインしたユーザーはレシピ登録ができる' do
      # ログインする
      sign_in(@user)
      # レシピ登録ページへのリンクがあることを確認する
      expect(page).to have_content('レシピ登録')
      # レシピ登録ページに移動する
      find('.add-recipe').click
      # フォームに情報を入力する
      fill_in 'recipe-name', with: @recipe.name
      fill_in 'calorie', with: @recipe.calorie
      fill_in 'time', with: @recipe.time
      attach_file 'recipe-image', "#{Rails.root}/public/images/test.jpg"
      find('option[value="14"]').select_option
      fill_in 'quantity', with: @recipe_ingredient.quantity
      # 登録するとRecipeモデルとRecipeIngredientモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Recipe.count }.by(1).and change { RecipeIngredient.count }.by(1)
      # レシピ登録後は、トップページに遷移することを確認する
      expect(current_path).to eq root_path
      # 「カレーライスのレシピを登録しました」の文字があることを確認する
      expect(page).to have_content("#{@recipe.name}のレシピを登録しました")
      # トップページには先ほど登録したレシピが存在することを確認する（画像）
      expect(page).to have_selector("img[src$='test.jpg']")
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（テキスト）
    end
  end
  context 'レシピ登録ができないとき'do
    it 'ログインしていないとトップページとレシピ登録ページに遷移できない' do
      # レシピ登録ページに移動する
      visit new_recipe_path
      # ログインページに遷移させられる
      expect(current_path).to eq new_user_session_path
    end
  end
end