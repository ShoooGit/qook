class UsersController < ApplicationController
  def guest_sign_in
    # ゲストユーザーのidは1
    user = User.find(1)
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーでログインしました。'
  end
end
