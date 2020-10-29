require 'rails_helper'

RSpec.describe '冷蔵庫登録', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context '冷蔵庫登録ができるとき'do
    it 'ログインしたユーザーはレシピ登録ができる' do
      # ログインする
      sign_in(@user)
      # 冷蔵庫ページへのリンクがあることを確認する
      expect(page).to have_link(href: "/refrigerators/new")
      # 冷蔵庫ページに移動する
      click_on("冷蔵庫へ")
      # 追加ボタンをクリックして、食材入力フォームを追加する
      click_on("追加")
      # 食材入力フォームが追加され、2つになっていることを確認する
      expect(all(:css, '.nested-fields').size).to eq (2)
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
      expect  do
        click_on("登録")
      end.to change { refrigerator.count }.by(1).and change { refrigeratorIngredient.count }.by(2)
      # レシピ登録後は、トップページに遷移することを確認する
      expect(current_path).to eq root_path
    end
  end
  # context 'レシピ登録ができないとき'do
  #   it 'ログインしていないとトップページとレシピ登録ページに遷移できない' do
  #     # レシピ登録ページに移動する
  #     visit new_refrigerator_path
  #     # ログインページに遷移させられる
  #     expect(current_path).to eq new_user_session_path
  #   end
  #   it '食材が重複すると、登録できない' do
  #     # ログインする
  #     sign_in(@user)
  #     # レシピ登録ページへのリンクがあることを確認する
  #     expect(page).to have_content('レシピ登録')
  #     # レシピ登録ページに移動する
  #     find('.add-refrigerator').click
  #     # フォームに情報を入力する
  #     fill_in 'refrigerator-name', with: @refrigerator.name
  #     fill_in 'calorie', with: @refrigerator.calorie
  #     fill_in 'time', with: @refrigerator.time
  #     attach_file 'refrigerator-image', "#{Rails.root}/public/images/test.jpg"
  #     # 追加ボタンをクリックして、食材入力フォームを追加する
  #     click_on("追加")
  #     # 食材入力フォームが追加され、2つになっていることを確認する
  #     expect(all(:css, '.nested-fields').size).to eq (2)
  #     # 1つ目の食材入力フォームへの入力
  #     within(all(:css, '.nested-fields')[0]) do
  #       find('option[value="14"]').select_option
  #       fill_in 'quantity', with: @refrigerator_ingredient.quantity
  #     end
  #     # 2つ目の食材入力フォームへの入力（重複した食材を入力）
  #     within(all(:css, '.nested-fields')[1]) do
  #       find('option[value="14"]').select_option
  #       fill_in 'quantity', with: @refrigerator_ingredient.quantity
  #     end
  #     # 食材が重複すると登録できないため、refrigeratorモデルとrefrigeratorIngredientモデルのカウントが上がらないことを確認する
  #     expect do
  #       click_on("登録")
  #     end.to change { refrigerator.count }.by(0).and change { refrigeratorIngredient.count }.by(0)
  #     # エラーメッセージが表示されていることを確認する
  #     expect(page).to have_content("重複する食材があります")
  #   end
  # end
end

