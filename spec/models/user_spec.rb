# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, 'userモデルの確認', type: :model do
  before do
    @user = FactoryBot.create(:user)
  end
  describe 'データの作成' do
    context '有効な内容の確認' do
      it '保存されるか' do
        expect(@user).to be_valid
      end
    end
    context '無効な内容の確認' do
      it 'nameが空白の時のエラーメッセージ' do
        @user.name = ''
        expect(@user).to be_invalid
        expect(@user.errors[:name]).to include('を入力してください')
      end
      it 'emailが空白の時のエラーメッセージ' do
        @user.email = ''
        expect(@user).to be_invalid
        expect(@user.errors[:email]).to include('を入力してください')
      end
      it 'sexが空白の時のエラーメッセージ' do
        @user.sex = ''
        expect(@user).to be_invalid
        expect(@user.errors[:sex]).to include('を入力してください')
      end
      it 'addressが空白の時のエラーメッセージ' do
        @user.address = ''
        expect(@user).to be_invalid
        expect(@user.errors[:address]).to include('を入力してください')
      end
      it 'nameが空白の時のエラーメッセージ' do
        @user.password = ''
        expect(@user).to be_invalid
        expect(@user.errors[:password]).to include('を入力してください')
      end
    end
  end
end