class ItemsController < ApplicationController
  def index
    if params[:tag]
      @items = Item.tagged_with(params[:tag])
    else
      @items = Item.all
    end
  end

  def show
    @item = Item.find(params[:id])
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
      redirect_to items_path, notice: 'Item was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @item = Item.find(params[:id])

    if @item.update_attributes(params[:item])
      redirect_to items_url, notice: 'Item was successfully updated.' 
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
