# -*- coding: utf-8 -*-
class ItemsController < ApplicationController
  before_filter :authorize

  def index
    @q = Item.search(params[:q])
    if params[:q]
      @items = @q.result.tagged_with(params[:tag]).all
    else
      @items = @q.result.tagged_with(params[:tag]).order("quantity ASC").all
    end
  end

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(params[:item])

    if @item.save
      redirect_to items_path, notice: 'アイテムを追加しました'
    else
      render action: "new"
    end
  end

  def update
    @item = Item.find(params[:id])

    if @item.update_attributes(params[:item])
      redirect_to items_path, notice: 'アイテムを更新しました'
    else
      render action: "edit" 
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    
    redirect_to items_url
  end
end
