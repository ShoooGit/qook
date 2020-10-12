require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@user).to be_valid
    end
    it 'nicknameが空だと登録できないこと' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('ニックネームを入力してください')
    end
    it 'emailが空だと登録できないこと' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('メールアドレスを入力してください')
    end
    it 'emailが重複すると保存できないこと' do
      FactoryBot.create(:user)
      @user.valid?
      expect(@user.errors.full_messages).to include('メールアドレスはすでに存在します')
    end
    it 'emailに「@」を含まないと保存できないこと' do
      @user.email = 'test'
      @user.valid?
      expect(@user.errors.full_messages).to include('メールアドレスは不正な値です')
    end
    it 'passwordが空では保存できないこと' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードを入力してください')
    end
    it 'passwordが6文字以下では保存できないこと' do
      @user.password = 'abc12'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
    end
    it 'passwordが半角英数字の組み合わせでないと保存できないこと(文字パターン)' do
      @user.password = 'テスト'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは半角英数字で入力してください')
    end
    it 'passwordが半角英数字の組み合わせでないと保存できないこと(数字のみパターン)' do
      @user.password = '111111'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは半角英数字で入力してください')
    end
    it 'passwordが半角英数字の組み合わせでないと保存できないこと(半角英字のみパターン)' do
      @user.password = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは半角英数字で入力してください')
    end
    it 'passwordとpassword_confirmationの値が一致しないと保存できないこと' do
      @user.password_confirmation = 'test'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
    end
  end
end
