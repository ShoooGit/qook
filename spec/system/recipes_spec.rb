require 'rails_helper'

RSpec.describe 'レシピ一覧', type: :system do
  before do
    @recipe1 = FactoryBot.create(:recipe)
    @user = @recipe1.user
    @recipe2 = FactoryBot.build(:recipe)
    @recipe2.user_id = @recipe1.user_id
    @recipe2.name = "test2"
    @recipe2.cook_flg = false
    @recipe2.save
  end
  context 'レシピ一覧が表示できるとき' do
    it 'ログインしたユーザーは調理可能なレシピを閲覧できる' do
      # ログインする
      sign_in(@user)
      
      # トップページには調理可能なレシピが存在することを確認する（画像）
      expect(page).to have_selector("img[src$='test.jpg']")

      # トップページには調理可能なレシピが存在することを確認する（テキスト）
      expect(page).to have_content(@recipe1.name)
      expect(page).to have_content(@recipe1.calorie)
      expect(page).to have_content(@recipe1.time)

      # トップページには調理不可能なレシピが存在しないことを確認する（テキスト）
      expect(page).to have_no_content(@recipe2.name)
      
    end
  end
end

RSpec.describe 'レシピ登録', type: :system do
  before do
    @recipe_ingredient = FactoryBot.build(:recipe_ingredient)
    @recipe = @recipe_ingredient.recipe
    @user = @recipe.user
    @user.save
    FactoryBot.create(:refrigerator, user_id: @user.id)
  end
  context 'レシピ登録ができるとき' do
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
      click_on('追加')
      # 食材入力フォームが追加され、2つになっていることを確認する
      expect(all(:css, '.nested-fields').size).to eq(2)
      # 1つ目の食材入力フォームへの入力
      within(all(:css, '.nested-fields')[0]) do
        find('option[value="14"]').select_option
        fill_in 'quantity', with: @recipe_ingredient.quantity
      end
      # 2つ目の食材入力フォームへの入力
      within(all(:css, '.nested-fields')[1]) do
        find('option[value="24"]').select_option
        fill_in 'quantity', with: @recipe_ingredient.quantity
        click_on('削除')
      end
      # 登録するとRecipeモデルのカウントが1、RecipeIngredientモデルのカウントが1上がることを確認する
      expect do
        click_on('登録')
      end.to change { Recipe.count }.by(1).and change { RecipeIngredient.count }.by(1)
      # レシピ登録後は、トップページに遷移することを確認する
      expect(current_path).to eq root_path
      # 「カレーライスのレシピを登録しました」の文字があることを確認する
      expect(page).to have_content("#{@recipe.name}のレシピを登録しました")
      # トップページには先ほど登録したレシピが存在することを確認する（画像）
      expect(page).to have_selector("img[src$='test.jpg']")
      # トップページには先ほど登録したレシピ名が存在することを確認する（テキスト）
      expect(page).to have_content(@recipe.name.to_s)
      expect(page).to have_content(@recipe.calorie.to_s)
      expect(page).to have_content(@recipe.time.to_s)
    end
  end
  context 'レシピ登録ができないとき' do
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
      click_on('追加')
      # 食材入力フォームが追加され、2つになっていることを確認する
      expect(all(:css, '.nested-fields').size).to eq(2)
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
        click_on('登録')
      end.to change { Recipe.count }.by(0).and change { RecipeIngredient.count }.by(0)
      # エラーメッセージが表示されていることを確認する
      expect(page).to have_content('重複する食材があります')
    end
  end
end

RSpec.describe 'レシピ詳細', type: :system do
  before do
    @recipe1 = FactoryBot.create(:recipe)
    @recipe1_ingredient = FactoryBot.create(:recipe_ingredient, recipe_id: @recipe1.id)
    @refrigerator1 = FactoryBot.create(:refrigerator, user_id: @recipe1.user.id)
    @refrigerator1_ingredient = FactoryBot.create(:refrigerator_ingredient, refrigerator_id: @refrigerator1.id)
    @recipe2 = FactoryBot.create(:recipe)
    @recipe2_ingredient = FactoryBot.create(:recipe_ingredient, recipe_id: @recipe2.id, quantity: 2)
    @refrigerator2 = FactoryBot.create(:refrigerator, user_id: @recipe2.user.id)
    @refrigerator2_ingredient = FactoryBot.create(:refrigerator_ingredient, refrigerator_id: @refrigerator2.id)
  end
  context 'レシピ詳細が確認できるとき' do
    it 'ログインしたユーザーは自分が登録したレシピ詳細を確認できる' do
      # レシピ1を登録したユーザーでログインする
      sign_in(@recipe1.user)
      # トップページにレシピ1へのリンクが存在することを確認する
      expect(page).to have_link(href: "/recipes/#{@recipe1.id}")
      # レシピ1の詳細ページへ遷移する
      click_link(href: "/recipes/#{@recipe1.id}")
      # レシピ1の登録内容が表示されていることを確認する

      # レシピ内容
      expect(page).to have_content(@recipe1.name)
      expect(page).to have_selector("img[src$='test.jpg']")
      expect(page).to have_content(@recipe1.calorie)
      expect(page).to have_content(@recipe1.time)

      # レシピの食材
      expect(page).to have_content(@recipe1_ingredient.ingredient.name)
      expect(page).to have_content(@recipe1_ingredient.quantity)

      # 編集ページのリンクが存在することを確認する
      expect(page).to have_link(href: "/recipes/#{@recipe1.id}/edit")
      # 削除ページのリンクが存在することを確認する
      expect(page).to have_link(href: "/recipes/#{@recipe1.id}")
    end
  end
  context '調理実行ができるとき' do
    it '調理に必要な食材が冷蔵庫に足りている場合は調理実行ボタンを押下できる' do
      # レシピ1を登録したユーザーでログインする
      sign_in(@recipe1.user)
      # トップページにレシピ1へのリンクが存在することを確認する
      expect(page).to have_link(href: "/recipes/#{@recipe1.id}")
      # レシピ1の詳細ページへ遷移する
      click_link(href: "/recipes/#{@recipe1.id}")
      # レシピ1の詳細ページの調理実行ボタンが有効になっていること
      expect(page).to have_link(href: "/recipes/#{@recipe1.id}/execute")
      # 調理実行ボタンを押下する
      click_link(href: "/recipes/#{@recipe1.id}/execute")
      # 調理実行後は、トップページに遷移することを確認する
      expect(current_path).to eq root_path
      # 「調理を実行し、冷蔵庫内の食材を消費しました」の文字があることを確認する
      expect(page).to have_content('調理を実行し、冷蔵庫内の食材を消費しました')
      # 冷蔵庫1の編集ページへ遷移する
      visit edit_refrigerator_path(@refrigerator1.id)
      # 食材が消費されていることを確認する
      expect(page).to have_no_content('削除')
    end
  end
  context 'レシピ詳細が確認できないとき' do
    it 'ログインしていないとレシピ詳細ページに遷移できない' do
      # レシピ詳細ページに移動する
      visit recipe_path(@recipe1.id)
      # ログインページに遷移させられる
      expect(current_path).to eq new_user_session_path
    end
    it '別ユーザーのレシピ詳細ページに遷移できない' do
      # レシピ1を登録したユーザーでログインする
      sign_in(@recipe1.user)
      # 別ユーザーのレシピ詳細ページに移動する
      visit recipe_path(@recipe2.id)
      # ログインページに遷移させられる
      expect(current_path).to eq root_path
    end
  end
  context '調理実行ができないとき' do
    it '調理に必要な食材が冷蔵庫に足りていない場合は調理実行ボタンを押下できない' do
      # レシピ2を登録したユーザーでログインする
      sign_in(@recipe2.user)

      # 冷蔵庫ページに移動する
      visit edit_refrigerator_path(@refrigerator2.id)

      # 1つ目の食材入力フォームへの入力
      within(all(:css, '.nested-fields')[0]) do
        find('option[value="14"]').select_option
        fill_in 'quantity', with: 1
      end

      click_on('確定')

      # 冷蔵庫登録後は、トップページに遷移することを確認する
      expect(current_path).to eq root_path
      
      # レシピ2の詳細ページへ遷移する
      visit recipe_path(@recipe2.id)
      # レシピ2の詳細ページの調理実行ボタンが無効になっていること
      expect(page).to have_content('調理に必要な食材が足りません')
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
      click_link('編集')
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
      fill_in 'recipe-name', with: @recipe1.name + 'edit'
      fill_in 'calorie', with: @recipe1.calorie + 1
      fill_in 'time', with: @recipe1.time + 1
      attach_file 'recipe-image', "#{Rails.root}/public/images/test2.jpg"
      # 追加ボタンをクリックして、食材入力フォームを追加する
      click_on('追加')
      # 食材入力フォームが追加され、2つになっていることを確認する
      expect(all(:css, '.nested-fields').size).to eq(2)
      # 2つ目の食材入力フォームへの入力
      within(all(:css, '.nested-fields')[1]) do
        find('option[value="24"]').select_option
        fill_in 'quantity', with: 99
      end
      # 登録するとRecipeモデルのカウントが0、RecipeIngredientモデルのカウントが1上がることを確認する
      expect do
        click_on('確定')
      end.to change { Recipe.count }.by(0).and change { RecipeIngredient.count }.by(1)
      # レシピ編集後は、詳細ページに遷移することを確認する
      expect(current_path).to eq recipe_path(@recipe1.id)
      # 「カレーライスeditのレシピを編集しました」の文字があることを確認する
      expect(page).to have_content("#{@recipe1.name}editのレシピを編集しました")
      # 詳細ページには先ほど編集したレシピが存在することを確認する（画像）
      expect(page).to have_selector("img[src$='test2.jpg']")
      # 詳細ページには先ほど編集したレシピが存在することを確認する（テキスト）
      expect(page).to have_content("#{@recipe1.name}edit")
      expect(page).to have_content((@recipe1.calorie + 1).to_s)
      expect(page).to have_content((@recipe1.time + 1).to_s)
      # 詳細ページには先ほど追加した食材が存在することを確認する（テキスト）
      expect(
        all(:css, '.foodstuff')[1]
      ).to have_content(@recipe1_ingredient.ingredient.name.to_s)
      expect(
        all(:css, '.foodstuff')[1]
      ).to have_content(@recipe1_ingredient.quantity.to_s)
      expect(
        all(:css, '.foodstuff')[0]
      ).to have_content('鶏むね肉')
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
      expect do
        click_link('削除')
      end.to change { Recipe.count }.by(-1).and change { RecipeIngredient.count }.by(-1)
      # トップページに遷移したことを確認する
      expect(current_path).to eq root_path
      # 「カレーライスのレシピを削除しました」の文字があることを確認する
      expect(page).to have_content("#{@recipe1.name}のレシピを削除しました")
      # トップページには先ほど登録したレシピが存在しないことを確認する（画像）
      expect(page).to have_no_selector("img[src$='test.jpg']")
      # トップページには先ほど登録したレシピが存在しないことを確認する（テキスト）
      expect(page).to have_no_content(/\A#{@recipe1.name}\z/)
      expect(page).to have_no_content(@recipe1.calorie.to_s)
      expect(page).to have_no_content(@recipe1.time.to_s)
    end
  end
end

RSpec.describe 'レシピ検索', type: :system do
  before do
    @recipe = FactoryBot.create(:recipe)
    @recipe_ingredient = FactoryBot.create(:recipe_ingredient, recipe_id: @recipe.id)
  end
  context 'レシピ検索ができるとき' do
    it 'ログインしたユーザーは自分が投稿したレシピの検索ができる' do
      # レシピ1を登録したユーザーでログインする
      sign_in(@recipe.user)
      # トップページに検索フォームが存在することを確認する
      expect(page).to have_selector('.search-form')
      # 検索するレシピを入力する
      fill_in 'input-box', with: @recipe.name
      # 検索ボタンを押下する
      click_on('search-button')
      # 検索結果ページに遷移したことを確認する
      expect(current_path).to eq search_recipes_path
      # 検索対象のレシピが存在することを確認する（画像）
      expect(page).to have_selector("img[src$='test.jpg']")
      # 検索対象のレシピ名が存在することを確認する（テキスト）
      expect(page).to have_content(@recipe.name.to_s)
      expect(page).to have_content(@recipe.calorie.to_s)
      expect(page).to have_content(@recipe.time.to_s)
    end
    it 'ログインしたユーザーは自分が投稿したレシピの検索ができる(検索結果なし)' do
      # レシピ1を登録したユーザーでログインする
      sign_in(@recipe.user)
      # トップページに検索フォームが存在することを確認する
      expect(page).to have_selector('.search-form')
      # 検索するレシピを入力する
      fill_in 'input-box', with: 'aaaaa'
      # 検索ボタンを押下する
      click_on('search-button')
      # 検索結果ページに遷移したことを確認する
      expect(current_path).to eq search_recipes_path
      # 検索対象のレシピが存在することを確認する（画像）
      expect(page).to have_no_selector("img[src$='test.jpg']")
      # 検索対象のレシピ名が存在することを確認する（テキスト）
      expect(page).to have_no_content(@recipe.name.to_s)
      expect(page).to have_no_content(@recipe.calorie.to_s)
      expect(page).to have_no_content(@recipe.time.to_s)
    end
  end
  context 'レシピ検索ができないとき' do
    it 'ログインしていないと検索結果ページに遷移できない' do
      # レシピ編集ページに移動する
      visit "/recipes/search?keyword=#{@recipe.name}&button="
      # ログインページに遷移させられる
      expect(current_path).to eq new_user_session_path
    end
  end
end
