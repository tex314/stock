module Taggable
  extend ActiveSupport::Concern

  included do
    attr_accessible :tag_list
    has_many :taggings
    has_many :tags, through: :taggings
  end

  module ClassMethods

    def tagged_with(name)
      name.present? ? Tag.find_by_name!(name).items : self
    end

    def tag_counts
      Tag.select("tags.id, tags.name, count(taggings.tag_id) as count").
          joins(:taggings).group("taggings.tag_id, tags.id, tags.name")
    end
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