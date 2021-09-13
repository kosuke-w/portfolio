class RegisteredItem < ApplicationRecord

  belongs_to :item, optional: true
  belongs_to :coordinate, optional: true


end
