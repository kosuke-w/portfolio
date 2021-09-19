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

  describe '投稿機能のテスト' do
    before do
      @post = FactoryBot.create(:post, user: @user)
      @post_comment = FactoryBot.create(:post_comment, user: @user, post: @post)
      visit posts_path
    end
    
    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/posts'
      end
      it 'titleが表示されている' do
        expect(page).to have_content @post.title
      end
      it 'textが表示されている' do
        expect(page).to have_content @post.text
      end
      it '投稿者名が表示されている' do
        expect(page).to have_content @post.user.name
      end
      it '新規投稿リンクが表示されている' do
        expect(page).to have_link 'to consult'
      end
      it '投稿詳細リンクが表示されている' do
        expect(page).to have_link @post.title
      end
    end
    
    context 'リンクの確認' do
      it 'to consultを押すと登録画面に遷移' do
        visit posts_path
        click_link 'to consult'
        expect(current_path).to eq '/posts/new'
      end
      it 'titleを押すと詳細画面に遷移' do
        visit posts_path
        click_link @post.title
        expect(current_path).to eq '/posts/' + @post.id.to_s
      end
    end
    
    context '新規投稿画面にて作成' do
      before do
        visit new_post_path
        fill_in 'post[title]', with:Faker::Lorem.characters(number:10)
        fill_in 'post[text]', with:Faker::Lorem.characters(number:30)
        attach_file 'post[image]', "#{Rails.root}/app/assets/images/test.png"
      end
      it '正しく登録される' do
        expect { click_button '投稿する' }.to change(Post.all, :count).by(1)
      end
      it '登録後のリダイレクト先が投稿一覧になっている' do
        click_button '投稿する'
        expect(current_path).to eq '/posts'
      end
    end
    
    context '投稿詳細画面の確認' do
      before do
        visit posts_path
        click_link @post.title
      end
      it 'urlが正しい' do
        expect(current_path).to eq '/posts/' + @post.id.to_s
      end
      it 'titleが表示されている' do
        expect(page).to have_content @post.title
      end
      it 'textが表示されている' do
        expect(page).to have_content @post.text
      end
      it '投稿者名が表示されている' do
        expect(page).to have_content @post.user.name
      end
      it '投稿者の性別が表示されている' do
        expect(page).to have_content @post.user.sex
      end
      it '添付画像が表示される(post+top+icon)' do
        expect(all('img').size).to eq(3)
      end
      it 'コメント投稿者名が表示されている' do
        expect(page).to have_content @post_comment.user.name
      end
      it 'コメント投稿者の性別が表示されている' do
        expect(page).to have_content @post_comment.user.sex
      end
      it '投稿削除リンクが表示されている' do
        expect(page).to have_link '投稿削除'
      end
      it 'コメント削除リンクが表示されている' do
        expect(page).to have_link 'コメント削除'
      end
      it '投稿削除クリックで正しく削除される' do
        expect { click_link '投稿削除' }.to change(Post.all, :count).by(-1)
      end
      it 'コメント削除クリックで正しく削除される' do
        expect { click_link 'コメント削除' }.to change(PostComment.all, :count).by(-1)
      end
    end
    
    context '投稿詳細画面にて新規コメント作成' do
      before do
        visit post_path(@post.id)
        fill_in 'post_comment[comment]', with:Faker::Lorem.characters(number:30)
      end
      it '正しく作成される' do
        expect { click_button 'コメントする' }.to change(PostComment.all, :count).by(1)
      end
      it '作成後のリダイレクト先が投稿一覧になっている' do
        click_button 'コメントする'
        expect(current_path).to eq '/posts/' + @post.id.to_s
      end
    end
  end
end