# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostComment, 'PostCommentモデルのテスト', type: :model do
  before do
    @post_comment = FactoryBot.create(:post_comment)
  end

  describe 'データ作成' do
    context '有効な内容の確認' do
      it '保存されるか' do
        expect(@post_comment).to be_valid
      end
    end

    context '無効な内容の確認' do
      it 'commentが空白の時のエラーメッセージ' do
        @post_comment.comment = ''
        expect(@post_comment).to be_invalid
        expect(@post_comment.errors[:comment]).to include('を入力してください')
      end
    end
  end

  describe 'アソシエーションの確認' do
    context 'userモデルとの関係' do
      it 'N:1になっているか' do
        expect(PostComment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'postモデルとの関係' do
      it 'N:1になっているか' do
        expect(PostComment.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end
