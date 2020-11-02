module SignInSupport
  def sign_in(user)
    # ログインページに移動
    visit new_user_session_path
    # メールアドレスとパスワードを入力
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    # ログインボタンを押下する
    find('input[value="ログイン"]').click
    # トップページに移動することを確認
    expect(current_path).to eq root_path
  end
end
