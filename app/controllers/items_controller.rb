# -*- coding: utf-8 -*-
class ItemsController < ApplicationController
  before_filter :authorize

  def index
    @q = current_user.items.search(params[:q])
    #    @q.sorts = "quantity asc"
    @q.sorts = "id desc"
    @items = @q.result.all
#    @items = @q.result.tagged_with(params[:tag]).all
  end

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item = current_user.items.build(params[:item])
##    @item = Item.new(params[:item])

    if @item.save
      redirect_to items_path, notice: 'アイテムを追加しました'
    else
      render action: "new"
    end
  end

  def update
    @item = current_user.items.find(params[:id])
#    @item = Item.find(params[:id])

    if @item.update_attributes(params[:item])
      redirect_to items_path, notice: 'アイテムを更新しました'
    else
      render action: "edit"
    end
  end

  def destroy
    @item = current_user.items.find(params[:id])
#    @item = Item.find(params[:id])
    @item.destroy

    redirect_to items_url
  end
end
