# frozen_string_literal: true

require 'rails_helper'

describe 'ログイン後のテスト' do
  before do
    @user = FactoryBot.create(:user)
    visit new_user_session_path
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user.password
    click_button 'Log in'
  end

  describe 'コーディネート機能のテスト' do
    before do
      @item = FactoryBot.create(:item, user: @user)
      @coordinate = FactoryBot.create(:coordinate, user: @user)
      @registered_item = FactoryBot.create(:registered_item, item: @item, coordinate: @coordinate)
      @other_user = FactoryBot.create(:user)
      @other_coordinate = FactoryBot.create(:coordinate, user: @other_user)
      visit coordinates_path
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/coordinates'
      end
      it 'コーデ名が表示されている' do
        expect(page).to have_content @coordinate.name
      end
      it 'コーデのシーズンが表示されている' do
        expect(page).to have_content @coordinate.season
      end
      it 'コーデのコメントが表示されている' do
        expect(page).to have_content @coordinate.comment
      end
      it '他人の登録アイテムが表示されない' do
        expect(page).to_not have_content @other_coordinate.name
      end
      it '新規コーデ作成リンクが表示されている' do
        expect(page).to have_link 'Add coordinate'
      end
      it '今日着たボタンが表示されている' do
        expect(page).to have_button '今日着た'
      end
      it '今日着たボタンを押してレコードが保存される' do
        expect { click_button '今日着た' }.to change(Record.all, :count).by(1)
      end
    end

    context 'リンクの確認' do
      it 'Add coordinateを押すと登録画面に遷移' do
        visit coordinates_path
        click_link 'Add coordinate'
        expect(current_path).to eq '/coordinates/new'
      end
    end

    context '新規登録画面にてコーデ登録' do
      before do
        visit new_coordinate_path
        check 'coordinate_item_ids_' + @item.id.to_s
        fill_in 'coordinate[name]', with:Faker::Lorem.characters(number:5)
        select '春', from: 'coordinate_season'
        fill_in 'coordinate[comment]', with:Faker::Lorem.characters(number:10)
      end
      it '正しく登録される' do
        expect { click_button '登録' }.to change(Coordinate.all, :count).by(1)
      end
      it '登録後のリダイレクト先がコーデ一覧になっている' do
        click_button '登録'
        expect(current_path).to eq '/coordinates'
      end
    end

    context 'コーデ詳細画面の確認' do
      before do
        visit coordinates_path
        click_link @coordinate.name
      end
      it 'urlが正しい' do
        expect(current_path).to eq '/coordinates/' + @coordinate.id.to_s
      end
      it 'nameが表示されている' do
        expect(page).to have_content @coordinate.name
      end
      it 'itemのnameが表示されている' do
        expect(page).to have_content @registered_item.item.name
      end
      it 'seasonが表示されている' do
        expect(page).to have_content @coordinate.season
      end
      it 'commentが表示されている' do
        expect(page).to have_content @coordinate.comment
      end
      it '編集リンクが表示されている' do
        expect(page).to have_link '編集する'
      end
      it '削除リンクが表示されている' do
        expect(page).to have_link '削除する'
      end
      it '編集をクリックで編集画面に遷移' do
        click_link '編集する'
        expect(current_path).to eq '/coordinates/' + @coordinate.id.to_s + '/edit'
      end
      it '削除クリックで正しく削除される' do
        expect { click_link '削除する' }.to change(Coordinate.all, :count).by(-1)
      end
    end

    context '編集機能の確認' do
      before do
        visit edit_coordinate_path(@coordinate.id)
        @coordinate_old_name = @coordinate.name
        @coordinate_old_season = @coordinate.season
        @coordinate_old_comment = @coordinate.comment
        fill_in 'coordinate[name]', with:Faker::Name.name
        select '夏', from: 'coordinate_season'
        fill_in 'coordinate[comment]', with:Faker::Lorem.characters(number:10)
        click_button '変更を保存'
      end
      it 'nameが正しく変更される' do
        expect(page).to_not eq @coordinate_old_name
      end
      it 'seasonが正しく変更される' do
        expect(page).to_not eq @coordinate_old_season
      end
      it 'commentが正しく変更される' do
        expect(page).to_not eq @coordinate_old_comment
      end
    end
  end
end