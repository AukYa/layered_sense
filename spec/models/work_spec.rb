require 'rails_helper'

describe '実際に保存してみる' do
  it '有効な投稿内容の場合は保存されるか' do
    expect(FactoryBot.build(:work)).to be_valid
  end
  it 'titleが空白の場合にバリデーションのエラーメッセージが返ってきているかどうか' do
    work = Work.new(title: '', introduction: 'hoge')
    expect(work).to be_invalid
    expect(work.errors[:title]).to include("can't be blank")
  end
end

# 実行結果：user_idとmusic_fileが無いので投稿が保存できず失敗