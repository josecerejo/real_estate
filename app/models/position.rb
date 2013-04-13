class Position < ActiveRecord::Base

  attr_accessor :item_id, :cart_id, :quantity

  belongs_to :item
  belongs_to :cart

end
