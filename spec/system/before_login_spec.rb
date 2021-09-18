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
  end
  
  describe 'ログイン前のヘッダーテスト' do
    context ''
  end
end