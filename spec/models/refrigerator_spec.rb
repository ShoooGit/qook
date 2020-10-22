require 'rails_helper'

RSpec.describe Refrigerator, type: :model do
  before do
    @refrigerator = FactoryBot.build(:refrigerator)
  end

  describe '冷蔵庫登録' do
    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@refrigerator).to be_valid
    end
    it 'ユーザーが紐付いていなければ登録できないこと' do
      @refrigerator.user = nil
      @refrigerator.valid?
      expect(@refrigerator.errors.full_messages).to include('ユーザーを入力してください')
    end
  end
end
