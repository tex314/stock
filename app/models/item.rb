class Item < ActiveRecord::Base
  attr_accessible :name, :quantity, :tag_list
  has_many :taggings
  has_many :tags, through: :taggings

  default_value_for :quantity, 1

  validates :name, :presence => true

  def none?
    quantity < 0
  end
  
  def self.tagged_with(name)
    name.present? ? Tag.find_by_name!(name).items : self
  end

  def self.tag_counts
    Tag.select("tags.id, tags.name, count(taggings.tag_id) as count").
      joins(:taggings).group("taggings.tag_id, tags.id, tags.name")
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end
