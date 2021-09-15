class Coordinate < ApplicationRecord

  belongs_to :user
  has_many :registered_items, dependent: :destroy
  has_many :items, through: :registered_items
  has_many :records, dependent: :destroy

  enum season: {
    春: 0, 夏: 1, 秋: 2, 冬: 3
  }

end
