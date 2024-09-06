require 'rails_helper'

describe '投稿のテスト' do
  let!(:user) { FactoryBot.create(:user) }
  let!(:tag) {FactoryBot.create(:tag) }
  let!(:work) { create(:work, user_id: user.id, title: "hoge", introduction: "huga", music_file: fixture_file_upload("spec/fixtures/music_file/guitar_solo.wav"), tag_ids: tag.id) }
  before do
    sign_in user
  end
  
  describe '投稿画面のテスト' do
    before do
      visit new_work_path
    end
    context '表示の確認' do
      it 'new_work_pathが"/works/new"であるか' do
        expect(current_path).to eq('/works/new')
      end
      it '投稿ボタンが表示されているか' do
        expect(page).to have_button 'Post'
      end
    end
    context '投稿処理のテスト' do
      it 'music_fileが入力されていない時は保存しない' do
        fill_in 'work[title]', with: Faker::Lorem.characters(number:5)
        fill_in 'work[introduction]', with: Faker::Lorem.characters(number:20)
        click_button 'Post'
        expect(page).to have_content "Music fileを入力してください"
      end
      it 'タイトルが入力されていない時は保存しない' do
        attach_file('work[music_file]', Rails.root.join('spec/fixtures/music_file/guitar_solo.wav')) 
        fill_in 'work[title]', with: ""
        fill_in 'work[introduction]', with: Faker::Lorem.characters(number:20)
        click_button 'Post'
        expect(page).to have_content "Titleを入力してください"
      end
      it '投稿後のリダイレクト先が正しいか' do
        attach_file('work[music_file]', Rails.root.join('spec/fixtures/music_file/guitar_solo.wav')) 
        fill_in 'work[title]', with: Faker::Lorem.characters(number:5)
        fill_in 'work[introduction]', with: Faker::Lorem.characters(number:20)
        click_button 'Post'
        expect(page).to have_current_path user_path(user)
      end
    end
    context 'workの削除のテスト' do
      it 'workの削除' do
        expect{ work.destroy }.to change{ Work.count }.by(-1)
      end
      it 'アソシエーションによるtagの削除' do
        expect{ work.destroy }.to change{ work.tags.count }.by(-1)
      end
    end
  end
  
  describe '詳細画面のテスト' do
    before do
      visit work_path(work)
    end
    context '表示の確認' do
      it 'titleとmusic_fileが表示されている' do
        expect(page).to have_content work.title
        expect(page).to have_selector 'audio'
      end
      it 'Editリンクが表示される' do
        expect(page).to have_link '作品の編集'
      end
      it 'Destroyリンクが表示される' do
        expect(page).to have_link '作品の削除'
      end
    end
    context 'リンクの遷移先の確認' do
      it 'Editの遷移先は編集画面か' do
        click_link '作品の編集'
        expect(current_path).to eq('/works/' + work.id.to_s + '/edit')
      end
    end
  end
  
  describe '一覧画面のテスト' do
    before do
      visit works_path
    end
    context '表示の確認' do
      # let!(:work1) { create(:work, user_id: user.id, title: 'hoge1', introduction: 'huga1', music_file: fixture_file_upload("spec/fixtures/music_file/guitar_solo.wav")) }
      # let!(:work2) { create(:work, user_id: user.id, title: 'hoge2', introduction: 'huga2', music_file: fixture_file_upload("spec/fixtures/music_file/guitar_solo.wav")) }
      # it 'workの順番が新しい順になっている' do
      #   expect(Work.all).to have_content(/#{work2.title}.*#{work1.title}/)
      # end
      # it '31投稿目からページネーションが表示されるか' do
      #   create_list(:work, 31, music_file: fixture_file_upload("spec/fixtures/music_file/guitar_solo.wav"))
      #   expect(page).to have_selector '.pagination', count: 1
      # end
    end
  end
  
  describe '編集画面のテスト' do
    before do
      visit edit_work_path(work)
    end
    context '表示の確認' do
      it '編集前のtitleがフォームにセットされている' do
        expect(page).to have_field 'work[title]', with: work.title
      end
      it '編集前のmusic_fileが表示されている' do
        expect(page).to have_content work.music_file.filename
      end
    end
    context '更新処理に関するテスト' do
      it '更新に失敗しエラーメッセージが表示される' do
        fill_in 'work[title]', with: ''
        fill_in 'work[introduction]', with: Faker::Lorem.characters(number: 30)
        click_button 'Save Changes'
        expect(page).to have_content '編集に失敗しました'
      end
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'work[title]', with: Faker::Lorem.characters(number: 10)
        fill_in 'work[introduction]', with: Faker::Lorem.characters(number: 30)
        click_button 'Save Changes'
        expect(page).to have_current_path work_path(work) 
      end
    end
  end
end

