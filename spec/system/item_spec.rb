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

  describe 'ログイン後のヘッダーテスト' do
    context 'リンク先確認' do
      it 'アイコンを押すとトップ画面に遷移' do
        click_on 'top'
        expect(current_path).to eq '/'
      end
      it 'iconを押すとマイページに遷移' do
        click_on 'icon'
        expect(current_path).to eq '/users/' + @user.id.to_s + '/my_page'
      end
      it 'My itemを押すとitems画面に遷移' do
        click_link('My item')
        expect(current_path).to eq('/items')
      end
      it 'My coodeを押すとcoordinates画面に遷移' do
        click_link('My coorde')
        expect(current_path).to eq('/coordinates')
      end
      it 'Postsを押すとitems画面に遷移' do
        click_link('Posts')
        expect(current_path).to eq('/posts')
      end
    end
  end

  describe 'items画面の確認' do
    before do
      @item = FactoryBot.create(:item, user: @user)
      @other_user = FactoryBot.create(:user)
      @other_item = FactoryBot.create(:item, user: @other_user)
      visit items_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/items'
      end
      it '自分の登録アイテムが表示される(item+top+icon)' do
        expect(all('img').size).to eq(3)
      end
      it 'アイテムのジャンル名が表示されている' do
        expect(page).to have_content @item.genre
      end
      it 'アイテムの登録名が表示されている' do
        expect(page).to have_content @item.name
      end
      it '他人の登録アイテムが表示されない' do
        expect(page).not_to have_content @other_item.image
      end
      it '新規登録リンクが表示されている' do
        expect(page).to have_link 'Add item'
      end
    end

    context 'リンクの確認' do
      it 'アイテム画像をクリックで詳細画面に遷移' do
        click_on 'item'
        expect(current_path).to eq '/items/' + @item.id.to_s
      end
      it 'Add itemを押すと登録画面に遷移' do
        visit items_path
        click_link 'Add item'
        expect(current_path).to eq '/items/new'
      end
    end

    context '新規登録画面にてアイテム登録' do
      before do
        visit new_item_path
        attach_file 'item[image]', "#{Rails.root}/app/assets/images/test.png"
        fill_in 'item[name]', with: Faker::Name.name
        select 'アウター', from: 'item_genre'
        select 'ベージュ', from: 'item_color'
        fill_in 'item[price]', with: Faker::Number.number(digits: 5)
        fill_in 'item[brand]', with: Faker::Lorem.characters(number: 5)
        fill_in 'item[caption]', with: Faker::Lorem.characters(number: 10)
      end

      it '正しく登録される' do
        expect { click_button '登録' }.to change(Item.all, :count).by(1)
      end
      it '登録後のリダイレクト先がアイテム一覧になっている' do
        click_button '登録'
        expect(current_path).to eq '/items'
      end
    end

    context 'アイテム詳細画面の確認' do
      before do
        visit items_path
        click_on 'item'
      end

      it 'urlが正しい' do
        expect(current_path).to eq '/items/' + @item.id.to_s
      end
      it '自分の登録アイテムが表示される(item+top+icon)' do
        expect(all('img').size).to eq(3)
      end
      it 'nameが表示されている' do
        expect(page).to have_content @item.name
      end
      it 'genreが表示されている' do
        expect(page).to have_content @item.genre
      end
      it 'colorが表示されている' do
        expect(page).to have_content @item.color
      end
      it 'priceが表示されている' do
        expect(page).to have_content @item.price.to_s(:delimited)
      end
      it 'brandが表示されている' do
        expect(page).to have_content @item.brand
      end
      it 'captionが表示されている' do
        expect(page).to have_content @item.caption
      end
      it '編集リンクが表示されている' do
        expect(page).to have_link '編集する'
      end
      it '削除リンクが表示されている' do
        expect(page).to have_link '削除する'
      end
      it '編集をクリックで編集画面に遷移' do
        click_link '編集する'
        expect(current_path).to eq '/items/' + @item.id.to_s + '/edit'
      end
      it '削除クリックで正しく削除される' do
        expect { click_link '削除する' }.to change(Item.all, :count).by(-1)
      end
    end

    context '編集機能の確認' do
      before do
        visit edit_item_path(@item.id)
        @item_old_name = @item.name
        @item_old_genre = @item.genre
        @item_old_color = @item.color
        fill_in 'item[name]', with: Faker::Name.name
        select 'トップス', from: 'item_genre'
        select 'ブルー', from: 'item_color'
        click_button '変更を保存'
      end

      it 'nameが正しく変更される' do
        expect(page).not_to eq @item_old_name
      end
      it 'genreが正しく変更される' do
        expect(page).not_to eq @item_old_genre
      end
      it 'colorが正しく変更される' do
        expect(page).not_to eq @item_old_color
      end
      it '編集リンクが表示されている' do
        expect(page).to have_link '編集する'
      end
    end
  end
end
