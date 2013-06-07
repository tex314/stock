class Item < ActiveRecord::Base
  include Taggable

  attr_accessible :name, :quantity
  validates :name, :presence => true

  default_value_for :quantity, 1

  def none?
    quantity < 0
  end
end
