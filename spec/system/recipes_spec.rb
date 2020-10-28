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
      # 追加ボタンをクリックして、食材入力フォームを追加する
      click_on("追加")
      # 食材入力フォームが追加され、2つになっていることを確認する
      expect(all(:css, '.nested-fields').size).to eq (2)
      # 1つ目の食材入力フォームへの入力
      within(all(:css, '.nested-fields')[0]) do
        find('option[value="14"]').select_option
        fill_in 'quantity', with: @recipe_ingredient.quantity
      end
      # 2つ目の食材入力フォームへの入力
      within(all(:css, '.nested-fields')[1]) do
        find('option[value="24"]').select_option
        fill_in 'quantity', with: @recipe_ingredient.quantity
        click_on("削除")
      end
      # 登録するとRecipeモデルのカウントが1、RecipeIngredientモデルのカウントが1上がることを確認する
      expect  do
        click_on("登録")
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
    it '食材が重複すると、登録できない' do
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
      # 追加ボタンをクリックして、食材入力フォームを追加する
      click_on("追加")
      # 食材入力フォームが追加され、2つになっていることを確認する
      expect(all(:css, '.nested-fields').size).to eq (2)
      # 1つ目の食材入力フォームへの入力
      within(all(:css, '.nested-fields')[0]) do
        find('option[value="14"]').select_option
        fill_in 'quantity', with: @recipe_ingredient.quantity
      end
      # 2つ目の食材入力フォームへの入力（重複した食材を入力）
      within(all(:css, '.nested-fields')[1]) do
        find('option[value="14"]').select_option
        fill_in 'quantity', with: @recipe_ingredient.quantity
      end
      # 食材が重複すると登録できないため、RecipeモデルとRecipeIngredientモデルのカウントが上がらないことを確認する
      expect do
        click_on("登録")
      end.to change { Recipe.count }.by(0).and change { RecipeIngredient.count }.by(0)
      # エラーメッセージが表示されていることを確認する
      expect(page).to have_content("重複する食材があります")
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
    it 'ログインしたユーザーは自分が登録したレシピ詳細を確認できる' do
      # レシピ1を登録したユーザーでログインする
      sign_in(@recipe1.user)
      # トップページにレシピ1へのリンクが存在することを確認する
      expect(page).to have_link(href: "/recipes/#{@recipe1.id}")
      # レシピ1の詳細ページへ遷移する
      click_link(href: "/recipes/#{@recipe1.id}")
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
      expect(page).to have_link(href: "/recipes/#{@recipe1.id}/edit")
      # 削除ページのリンクが存在することを確認する
      expect(page).to have_link(href: "/recipes/#{@recipe1.id}")
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

RSpec.describe 'レシピ編集', type: :system do
  before do
    @recipe1 = FactoryBot.create(:recipe)
    @recipe1_ingredient = FactoryBot.create(:recipe_ingredient, recipe_id: @recipe1.id)
    @recipe2 = FactoryBot.create(:recipe)
    @recipe2_ingredient = FactoryBot.create(:recipe_ingredient, recipe_id: @recipe2.id)
  end
  context 'レシピ編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したレシピの編集ができる' do
      # レシピ1を登録したユーザーでログインする
      sign_in(@recipe1.user)
      # トップページにレシピ1へのリンクが存在することを確認する
      expect(page).to have_link(href: "/recipes/#{@recipe1.id}")
      # レシピ1の詳細ページへ遷移する
      click_link(href: "/recipes/#{@recipe1.id}")
      # 編集ページへ遷移する
      click_link("編集")
      # すでに登録済みの内容がフォームに入っていることを確認する
      expect(
        find_by_id('recipe-name').value
      ).to eq @recipe1.name
      expect(
        find_by_id('calorie').value.to_i
      ).to eq @recipe1.calorie
      expect(
        find_by_id('time').value.to_i
      ).to eq @recipe1.time
      expect(
        find_by_id('ingredient').value.to_i
      ).to eq @recipe1_ingredient.ingredient_id
      expect(
        find_by_id('quantity').value.to_i
      ).to eq @recipe1_ingredient.quantity
      # 登録内容を編集する
      fill_in 'recipe-name', with: @recipe1.name + "edit"
      fill_in 'calorie', with: @recipe1.calorie + 1
      fill_in 'time', with: @recipe1.time + 1
      attach_file 'recipe-image', "#{Rails.root}/public/images/test2.jpg"
      # 追加ボタンをクリックして、食材入力フォームを追加する
      click_on("追加")
      # 食材入力フォームが追加され、2つになっていることを確認する
      expect(all(:css, '.nested-fields').size).to eq (2)
      # 2つ目の食材入力フォームへの入力
      within(all(:css, '.nested-fields')[1]) do
        find('option[value="24"]').select_option
        fill_in 'quantity', with: 99
      end
      # 登録するとRecipeモデルのカウントが0、RecipeIngredientモデルのカウントが1上がることを確認する
      expect  do
        click_on("確定")
      end.to change { Recipe.count }.by(0).and change { RecipeIngredient.count }.by(1)
      # レシピ編集後は、詳細ページに遷移することを確認する
      expect(current_path).to eq recipe_path(@recipe1.id)
      # 「カレーライスeditのレシピを編集しました」の文字があることを確認する
      expect(page).to have_content("#{@recipe1.name}editのレシピを編集しました")
      # 詳細ページには先ほど編集したレシピが存在することを確認する（画像）
      expect(page).to have_selector("img[src$='test2.jpg']")
      # 詳細ページには先ほど編集したレシピが存在することを確認する（テキスト）
      expect(page).to have_content("#{@recipe1.name}edit")
      expect(page).to have_content("#{@recipe1.calorie + 1}")
      expect(page).to have_content("#{@recipe1.time + 1}")
      # 詳細ページには先ほど追加した食材が存在することを確認する（テキスト）
      expect(
        all(:css, '.foodstuff')[1] 
      ).to have_content("#{@recipe1_ingredient.ingredient.name}")
      expect(
        all(:css, '.foodstuff')[1] 
      ).to have_content("#{@recipe1_ingredient.quantity}")
      expect(
        all(:css, '.foodstuff')[0] 
      ).to have_content("鶏むね肉")
      expect(
        all(:css, '.foodstuff')[0] 
      ).to have_content(99)
    end
  end
  context 'レシピ編集ができないとき' do
    it 'ログインしていないとレシピ編集ページに遷移できない' do
      # レシピ編集ページに移動する
      visit edit_recipe_path(@recipe1.id)
      # ログインページに遷移させられる
      expect(current_path).to eq new_user_session_path
    end
    it '別ユーザーのレシピ編集ページに遷移できない' do
      # レシピ1を登録したユーザーでログインする
      sign_in(@recipe1.user)
      # 別ユーザーのレシピ編集ページに移動する
      visit edit_recipe_path(@recipe2.id)
      # ログインページに遷移させられる
      expect(current_path).to eq root_path
    end
  end
end

RSpec.describe 'レシピ削除', type: :system do
  before do
    @recipe1 = FactoryBot.create(:recipe)
    @recipe1_ingredient = FactoryBot.create(:recipe_ingredient, recipe_id: @recipe1.id)
    @recipe2 = FactoryBot.create(:recipe)
    @recipe2_ingredient = FactoryBot.create(:recipe_ingredient, recipe_id: @recipe2.id)
  end
  context 'レシピ削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿したレシピの削除ができる' do
      # レシピ1を登録したユーザーでログインする
      sign_in(@recipe1.user)
      # トップページにレシピ1へのリンクが存在することを確認する
      expect(page).to have_link(href: "/recipes/#{@recipe1.id}")
      # レシピ1の詳細ページへ遷移する
      click_link(href: "/recipes/#{@recipe1.id}")
      # レシピを削除するとレコードの数が1減ることを確認する
      expect  do
        click_link("削除")
      end.to change { Recipe.count }.by(-1).and change { RecipeIngredient.count }.by(-1)
      # トップページに遷移したことを確認する
      expect(current_path).to eq root_path
      # 「カレーライスのレシピを削除しました」の文字があることを確認する
      expect(page).to have_content("#{@recipe1.name}のレシピを削除しました")
      # トップページには先ほど登録したレシピが存在しないことを確認する（画像）
      expect(page).to have_no_selector("img[src$='test.jpg']")
      # トップページには先ほど登録したレシピが存在しないことを確認する（テキスト）
      expect(page).to have_no_content(/\A#{@recipe1.name}\z/)
      expect(page).to have_no_content("#{@recipe1.calorie}")
      expect(page).to have_no_content("#{@recipe1.time}")
    end
  end
end