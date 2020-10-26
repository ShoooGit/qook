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
      expect(page).to have_content("#{@recipe.name}")
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

RSpec.describe 'レシピ編集', type: :system do
  before do
    @recipe1 = FactoryBot.create(:recipe)
    @recipe2 = FactoryBot.create(:recipe)
  end
  context 'レシピ編集ができるとき'do
    it 'ログインしたユーザーは自分が登録したレシピの編集ができる' do
      # レシピ1を登録したユーザーでログインする
      sign_in(@recipe1.user)
      # レシピ1のリンクをクリックする
      click_link "/recipes/#{@recipe1.id}"
      # 編集ページへ遷移する

      # すでに投稿済みの内容がフォームに入っていることを確認する
      # 投稿内容を編集する
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      # 編集完了画面に遷移したことを確認する
      # 「更新が完了しました」の文字があることを確認する
      # トップページに遷移する
      # トップページには先ほど変更した内容のツイートが存在することを確認する（画像）
      # トップページには先ほど変更した内容のツイートが存在することを確認する（テキスト）
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