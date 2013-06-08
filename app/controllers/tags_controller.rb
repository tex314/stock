class TagsController < ApplicationController
  before_filter :authorize

  def index
    @tags = Tag.all
  end
end
