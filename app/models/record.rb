class Record < ApplicationRecord
  belongs_to :coordinate, optional: true

  validates :start_time, uniqueness: true
end
