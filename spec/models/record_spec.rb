# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Coordinate, 'Coordinateモデルのテスト', type: :model do
  before do
    @record = FactoryBot.create(:record)
  end
   describe 'データ作成' do
    context '有効な内容の確認' do
      it '保存されるか' do
        expect(@record).to be_valid
      end
    end
  end
end