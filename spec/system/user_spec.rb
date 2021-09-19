# frozen_string_literal: true

require 'rails_helper'

describe 'ログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'urlが正しい' do
        expect(current_path).to eq '/'
      end
      it 'log_inリンクが存在する' do
        expect(page).to have_link '', href: new_user_session_path
      end
      it 'sign_upリンクが存在する' do
        expect(page).to have_link '', href: new_user_registration_path
      end
    end
    context 'リンクの内容確認' do
      it 'アイコンを押すとトップ画面に遷移' do
        click_on 'top'
        expect(current_path).to eq('/')
      end
      it 'Sign upを押すと新規登録画面に遷移' do
        click_link('Sign up')
        expect(current_path).to eq('/users/sign_up')
      end
      it 'Log inを押すと新規登録画面に遷移' do
        click_link('Log in')
        expect(current_path).to eq('/users/sign_in')
      end
    end
  end
end

describe 'ユーザー新規登録テスト' do
  before do
    visit new_user_registration_path
  end
  context '登録ページ表示内容の確認' do
    it 'urlが正しい' do
      expect(current_path).to eq('/users/sign_up')
    end
    it 'Sign upと表示される' do
      expect(page).to have_content('Sign up')
    end
    it 'nameフォームが表示される' do
      expect(page).to have_field('user[name]')
    end
    it 'emailフォームが表示される' do
      expect(page).to have_field('user[email]')
    end
    it 'passwordフォームが表示される' do
      expect(page).to have_field('user[password]')
    end
    it 'sexフォームが表示される' do
      expect(page).to have_field('user[sex]')
    end
    it 'addressフォームが表示される' do
      expect(page).to have_field('user[address]')
    end
    it 'Sign upボタンが表示される' do
      expect(page).to have_button('Sign up')
    end
  end

  context '実際の登録確認' do
    before do
      fill_in 'user[name]', with:Faker::Name.name
      fill_in 'user[email]', with:Faker::Internet.email
      choose 'user_sex_男性'
      select '北海道', from: 'user_address'
      password = Faker::Internet.password(min_length: 6)
      fill_in 'user[password]', with:password
      fill_in 'user[password_confirmation]', with:password
    end

    it '正しく登録される' do
      expect { click_button 'Sign up' }.to change(User.all, :count).by(1)
    end
    it '登録後のリダイレクト先がマイページになっている' do
      click_button 'Sign up'
      expect(current_path).to eq '/users/' + User.last.id.to_s + '/my_page'
    end
  end
end

describe 'ログインテスト' do
  before do
    @user = FactoryBot.create(:user)
    visit new_user_session_path
  end
  context 'ログインページ表示内容の確認' do
    it 'urlが正しい' do
      expect(current_path).to eq('/users/sign_in')
    end
    it 'Log inと表示される' do
      expect(page).to have_content('Log in')
    end
    it 'emailフォームが表示される' do
      expect(page).to have_field('user[email]')
    end
    it 'passwordフォームが表示される' do
      expect(page).to have_field('user[password]')
    end
    it 'Log inボタンが表示される' do
      expect(page).to have_button('Log in')
    end
  end

  context '実際のログイン確認' do
    before do
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      click_button 'Log in'
    end
    it 'ログイン後のリダイレクト先がマイページになっている' do
      expect(current_path).to eq '/users/' + @user.id.to_s + '/my_page'
    end
  end

  context 'ログイン失敗確認' do
    before do
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: ''
      click_button 'Log in'
    end
    it 'ログインに失敗し、ログイン画面に戻る' do
      expect(current_path).to eq '/users/sign_in'
    end
  end
end

describe 'ログイン後の確認' do
  before do
    @user = FactoryBot.create(:user)
    visit new_user_session_path
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user.password
    click_button 'Log in'
  end
  context 'ヘッダーの情報確認' do
    it 'topリンクが存在する' do
      expect(page).to have_link '', href: root_path
    end
    it 'mypageリンクが存在する' do
      expect(page).to have_link '', href: my_page_user_path(@user.id)
    end
    it 'itemsリンクが表示される' do
      expect(page).to have_link 'My item', href: items_path
    end
    it 'coordinatesリンクが表示される' do
      expect(page).to have_link 'My coorde', href: coordinates_path
    end
    it 'postsリンクが表示される' do
      expect(page).to have_link 'Posts', href: posts_path
    end
    it 'logoutリンクが表示される' do
      expect(page).to have_link 'Log out', href: destroy_user_session_path
    end
  end

  context '編集機能の確認' do
    before do
      visit edit_user_path(@user.id)
      @user_old_name = @user.name
      @user_old_sex = @user.sex
      @user_old_address = @user.address
      attach_file 'user[image]', "#{Rails.root}/app/assets/images/test.png"
      fill_in 'user[name]', with: Faker::Name.name
      choose 'user_sex_女性'
      select '沖縄県', from: 'user_address'
      fill_in 'user[introduction]', with:Faker::Lorem.characters(number:10)
      click_button '変更を保存'
    end
    it 'nameが正しく変更される' do
      expect(page).to_not eq @user_old_name
    end
    it 'sexが正しく変更される' do
      expect(page).to_not eq @user_old_sex
    end
    it 'addressが正しく変更される' do
      expect(page).to_not eq @user_old_address
    end
  end

  context 'マイページの表示' do
    it 'カレンダーが表示されているか' do
      expect(page).to have_content '日'
    end
  end
end

describe 'ユーザーのログアウト機能' do
  before do
    @user = FactoryBot.create(:user)
    visit new_user_session_path
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user.password
    click_button 'Log in'
    click_link 'Log out'
  end
  context '正しくログアウトできているか' do
    it 'ログアウト後のリダイレクト先がトップになっている' do
      expect(current_path).to eq '/'
    end
  end
end