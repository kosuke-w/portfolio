# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Coordinate, 'Coordinateモデルのテスト', type: :model do
  before do
    @coordinate = FactoryBot.create(:coordinate)
  end
  describe 'データ作成' do
    context '有効な内容の確認' do
      it '保存されるか' do
        expect(@coordinate).to be_valid
      end
    end
    context '無効な内容の確認' do
      it 'nameが空欄のときのエラーメッセージ' do
        @coordinate.name = ''
        expect(@coordinate).to be_invalid
        expect(@coordinate.errors[:name]).to include("を入力してください")
      end
      it 'seasonが空欄のときのエラーメッセージ' do
        @coordinate.season = ''
        expect(@coordinate).to be_invalid
        expect(@coordinate.errors[:season]).to include("を入力してください")
      end
    end
  end
  describe 'アソシエーションの確認' do
    context 'userモデルとの関係' do
      it 'N:1になっているか' do
        expect(Coordinate.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end