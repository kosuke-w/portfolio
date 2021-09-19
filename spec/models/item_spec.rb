# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, "モデルに関するテスト", type: :model do
  before do
    @item = FactoryBot.create(:item)
  end
  describe '実際に保存してみる' do
    context '有効なデータのチェック' do
      it "有効な内容の場合は保存されるか" do
        expect(@item).to be_valid
      end
    end
    context '空白のバリデーションチェック' do
      it 'nameが空白のときのエラーメッセージ' do
        @item.name = ''
        expect(@item).to be_invalid
        expect(@item.errors[:name]).to include("を入力してください")
      end
      it 'imageが空白のときのエラーメッセージ' do
        @item.image_id = ''
        expect(@item).to be_invalid
        expect(@item.errors[:image]).to include("を入力してください")
      end
      it 'genreが空白のときのエラーメッセージ' do
        @item.genre = ''
        expect(@item).to be_invalid
        expect(@item.errors[:genre]).to include("を入力してください")
      end
      it 'colorが空白のときのエラーメッセージ' do
        @item.color = ''
        expect(@item).to be_invalid
        expect(@item.errors[:color]).to include("を入力してください")
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'userモデルとの関係' do
      it 'N:1となっている' do
        expect(Item.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end