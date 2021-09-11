class Item < ApplicationRecord

  belongs_to :user
  belongs_to :coordinate

  attachment :image

end
