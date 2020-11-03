require 'rails_helper'

RSpec.describe '冷蔵庫登録', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @refrigerator_ingredient = FactoryBot.build(:refrigerator_ingredient)
  end
  context '冷蔵庫登録ができるとき' do
    it 'ログインしたユーザーは冷蔵庫登録ができる' do
      # ログインする
      sign_in(@user)
      # 冷蔵庫ページへのリンクがあることを確認する
      expect(page).to have_link(href: '/refrigerators/new')
      # 冷蔵庫ページに移動する
      visit new_refrigerator_path
      # 追加ボタンをクリックして、食材入力フォームを追加する
      click_on('追加')
      # 食材入力フォームが追加され、2つになっていることを確認する
      expect(all(:css, '.nested-fields').size).to eq(2)
      # 1つ目の食材入力フォームへの入力
      within(all(:css, '.nested-fields')[0]) do
        find('option[value="14"]').select_option
        fill_in 'quantity', with: @refrigerator_ingredient.quantity
      end
      # 2つ目の食材入力フォームへの入力
      within(all(:css, '.nested-fields')[1]) do
        find('option[value="24"]').select_option
        fill_in 'quantity', with: @refrigerator_ingredient.quantity
      end
      # 登録するとrefrigeratorモデルのカウントが1、refrigeratorIngredientモデルのカウントが1上がることを確認する
      expect do
        click_on('確定')
      end.to change { Refrigerator.count }.by(1).and change { RefrigeratorIngredient.count }.by(2)
      # 冷蔵庫登録後は、トップページに遷移することを確認する
      expect(current_path).to eq root_path
    end
  end
  context '冷蔵庫登録ができないとき' do
    it 'ログインしていないと冷蔵庫登録ページに遷移できない' do
      # 冷蔵庫登録ページに移動する
      visit new_refrigerator_path
      # ログインページに遷移させられる
      expect(current_path).to eq new_user_session_path
    end
    it '食材が重複すると、登録できない' do
      # ログインする
      sign_in(@user)
      # 冷蔵庫ページへのリンクがあることを確認する
      expect(page).to have_link(href: '/refrigerators/new')
      # 冷蔵庫ページに移動する
      visit new_refrigerator_path
      # 追加ボタンをクリックして、食材入力フォームを追加する
      click_on('追加')
      # 食材入力フォームが追加され、2つになっていることを確認する
      expect(all(:css, '.nested-fields').size).to eq(2)
      # 1つ目の食材入力フォームへの入力
      within(all(:css, '.nested-fields')[0]) do
        find('option[value="14"]').select_option
        fill_in 'quantity', with: @refrigerator_ingredient.quantity
      end
      # 2つ目の食材入力フォームへの入力（重複した食材を入力）
      within(all(:css, '.nested-fields')[1]) do
        find('option[value="14"]').select_option
        fill_in 'quantity', with: @refrigerator_ingredient.quantity
      end
      # 食材が重複すると登録できないため、refrigeratorモデルとrefrigeratorIngredientモデルのカウントが上がらないことを確認する
      expect do
        click_on('確定')
      end.to change { Refrigerator.count }.by(0).and change { RefrigeratorIngredient.count }.by(0)
      # エラーメッセージが表示されていることを確認する
      expect(page).to have_content('重複する食材があります')
    end
  end
end

RSpec.describe '冷蔵庫編集', type: :system do
  before do
    @refrigerator1 = FactoryBot.create(:refrigerator)
    @refrigerator1_ingredient = FactoryBot.create(:refrigerator_ingredient, refrigerator_id: @refrigerator1.id)
    @refrigerator2 = FactoryBot.create(:refrigerator)
    @refrigerator2_ingredient = FactoryBot.create(:refrigerator_ingredient, refrigerator_id: @refrigerator2.id)
  end
  context '冷蔵庫編集ができるとき' do
    it 'ログインしたユーザーは自分の冷蔵庫の編集ができる' do
      # 冷蔵庫1を登録したユーザーでログインする
      sign_in(@refrigerator1.user)
      # トップページに冷蔵庫1へのリンクが存在することを確認する
      expect(page).to have_link(href: "/refrigerators/#{@refrigerator1.id}/edit")
      # 冷蔵庫1の編集ページへ遷移する
      visit edit_refrigerator_path(@refrigerator1.id)
      # すでに登録済みの内容が表示されていることを確認する
      expect(
        find_by_id('ingredient').value.to_i
      ).to eq @refrigerator1_ingredient.ingredient_id
      expect(
        find_by_id('quantity').value.to_i
      ).to eq @refrigerator1_ingredient.quantity
      # 追加ボタンをクリックして、食材入力フォームを追加する
      click_on('追加')
      # 食材入力フォームが追加され、2つになっていることを確認する
      expect(all(:css, '.nested-fields').size).to eq(2)
      # 2つ目の食材入力フォームへの入力
      within(all(:css, '.nested-fields')[1]) do
        find('option[value="24"]').select_option
        fill_in 'quantity', with: 99
      end
      # 登録するとrefrigeratorモデルのカウントが0、refrigeratorIngredientモデルのカウントが1上がることを確認する
      expect do
        click_on('確定')
      end.to change { Refrigerator.count }.by(0).and change { RefrigeratorIngredient.count }.by(1)
      # 冷蔵庫編集後は、トップページに遷移することを確認する
      expect(current_path).to eq root_path
      # 「カレーライスeditの冷蔵庫を編集しました」の文字があることを確認する
      expect(page).to have_content('冷蔵庫の内容を更新しました')
      # 冷蔵庫1の編集ページへ遷移する
      visit edit_refrigerator_path(@refrigerator1.id)
      # すでに登録済みの内容が表示されていることを確認する
      expect(
        all(:id, 'ingredient')[1].value.to_i
      ).to eq @refrigerator1_ingredient.ingredient_id
      expect(
        all(:id, 'quantity')[1].value.to_i
      ).to eq @refrigerator1_ingredient.quantity
      # 24は鶏もも肉
      expect(
        all(:id, 'ingredient')[0].value.to_i
      ).to eq 24
      expect(
        all(:id, 'quantity')[0].value.to_i
      ).to eq 99
    end
  end
  context '冷蔵庫編集ができないとき' do
    it 'ログインしていないと冷蔵庫編集ページに遷移できない' do
      # 冷蔵庫編集ページに移動する
      visit edit_refrigerator_path(@refrigerator1.id)
      # ログインページに遷移させられる
      expect(current_path).to eq new_user_session_path
    end
    it '別ユーザーの冷蔵庫編集ページに遷移できない' do
      # 冷蔵庫1を登録したユーザーでログインする
      sign_in(@refrigerator1.user)
      # 別ユーザーの冷蔵庫編集ページに移動する
      visit edit_refrigerator_path(@refrigerator2.id)
      # ログインページに遷移させられる
      expect(current_path).to eq root_path
    end
    it 'すでに冷蔵庫を登録しているユーザは冷蔵庫登録ページに遷移できない' do
      # 冷蔵庫1を登録したユーザーでログインする
      sign_in(@refrigerator1.user)
      # 別ユーザーの冷蔵庫編集ページに移動する
      visit new_refrigerator_path
      # ログインページに遷移させられる
      expect(current_path).to eq root_path
    end
  end
end
