class Item < ActiveRecord::Base
  include Taggable

  belongs_to :user

  attr_accessible :name, :quantity, :user_id
  validates :name, :presence => true

  default_value_for :quantity, 1

  def none?
    quantity < 0
  end
end
