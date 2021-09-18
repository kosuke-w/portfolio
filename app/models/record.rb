class Record < ApplicationRecord

  belongs_to :coordinate, optional: true

  validates :coordinate_id, uniqueness: true

end
