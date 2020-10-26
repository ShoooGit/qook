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
      # トップページには先ほど登録したレシピ名が存在することを確認する（テキスト）
      expect(page).to have_content("#{@recipe.name}")
      expect(page).to have_content("#{@recipe.calorie}")
      expect(page).to have_content("#{@recipe.time}")
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

RSpec.describe 'レシピ詳細', type: :system do
  before do
    @recipe1 = FactoryBot.create(:recipe)
    @recipe1_ingredient = FactoryBot.create(:recipe_ingredient, recipe_id: @recipe1.id)
    @recipe2 = FactoryBot.create(:recipe)
    @recipe2_ingredient = FactoryBot.create(:recipe_ingredient, recipe_id: @recipe2.id)
  end
  context 'レシピ詳細が確認できるとき'do
    it 'ログインしたユーザーは自分が登録したレシピの編集ができる' do
      # レシピ1を登録したユーザーでログインする
      sign_in(@recipe1.user)
      # トップページにレシピ1へのリンクが存在することを確認する
      expect(page).to have_link href: "/recipes/#{@recipe1.id}"
      # レシピ1の詳細ページへ遷移する
      click_link href: "/recipes/#{@recipe1.id}"
      # レシピ1の登録内容が表示されていることを確認する
      # レシピ内容
      expect(page).to have_content("#{@recipe1.name}")
      expect(page).to have_selector("img[src$='test.jpg']")
      expect(page).to have_content("#{@recipe1.calorie}")
      expect(page).to have_content("#{@recipe1.time}")

      # レシピの食材
      expect(page).to have_content("#{@recipe1_ingredient.ingredient.name}")
      expect(page).to have_content("#{@recipe1_ingredient.quantity}")

      # 編集ページのリンクが存在することを確認する
      expect(page).to have_link href: "/recipes/#{@recipe1.id}/edit"
      # 削除ページのリンクが存在することを確認する
      expect(page).to have_link href: "/recipes/#{@recipe1.id}"
    end
  end
  context 'レシピ詳細が確認できないとき'do
    it 'ログインしていないとレシピ詳細ページに遷移できない' do
      # レシピ登録ページに移動する
      visit recipe_path(@recipe1.id)
      # ログインページに遷移させられる
      expect(current_path).to eq new_user_session_path
    end
    it '別ユーザーのレシピ詳細ページに遷移できない' do
      # レシピ1を登録したユーザーでログインする
      sign_in(@recipe1.user)
      # 別ユーザーのレシピ登録ページに移動する
      visit recipe_path(@recipe2.id)
      # ログインページに遷移させられる
      expect(current_path).to eq root_path
    end
  end
end