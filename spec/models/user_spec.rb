require 'rails_helper'

 describe 'ユーザー新規登録' do
  before do
    @user = FactoryBot.build(:user)
  end
  
  it 'nameが空だと登録できない' do
    @user.name = ' '
    @user.valid?
    expect(@user.errors.full_messages).to include "名前を入力してください"
  end
end