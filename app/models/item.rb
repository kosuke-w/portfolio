class Item < ApplicationRecord

  belongs_to :user
  has_many :registered_items, dependent: :destroy
  has_many :coordinates, through: :registered_items

  attachment :image

  enum genre: {
    アウター: 0, トップス: 1, インナー: 2, パンツ: 3, シューズ: 4, その他: 5
  }

  enum color: {
    ベージュ: 0, ブルー: 1, グリーン: 2, イエロー: 3, レッド: 4, パープル: 5, ブラウン: 6, グレー: 7, ブラック: 8, ホワイト: 9
  }

end
