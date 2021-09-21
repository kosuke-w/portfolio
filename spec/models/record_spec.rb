# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Record, 'レコードモデルのテスト', type: :model do
  before do
    item = FactoryBot.create(:item)
    coordinate = FactoryBot.create(:coordinate, item_ids: item.id)
    @record = FactoryBot.create(:record, coordinate: coordinate)
  end

  describe 'データ作成' do
    context '有効な内容の確認' do
      it '保存されるか' do
        expect(@record).to be_valid
      end
    end
  end
end
