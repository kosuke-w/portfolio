# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, 'Postモデルのテスト', type: :model do
  before do
    @post = FactoryBot.create(:post)
  end

  describe 'データの作成' do
    context '有効な内容の確認' do
      it '保存されるか' do
        expect(@post).to be_valid
      end
    end

    context '無効な内容の確認' do
      it 'titleが空白の時のエラーメッセージ' do
        @post.title = ''
        expect(@post).to be_invalid
        expect(@post.errors[:title]).to include('を入力してください')
      end
      it 'textが空白の時のエラーメッセージ' do
        @post.text = ''
        expect(@post).to be_invalid
        expect(@post.errors[:text]).to include('を入力してください')
      end
    end
  end

  describe 'アソシエーションの確認' do
    context 'userモデルとの関係' do
      it 'N:1になっているか' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
