class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(item_params[:id])
  end

  def update
    item = Item.find(item_params[:id])
    if item.update(item_params)
      redirect_to "/items/#{item.id}"
      flash[:alert] = "Item Information Successfully Updated!"
    else
      redirect_to "/items/#{item.id}/edit"
      flash[:alert] = "Error: Please Fill in All Fields"
    end
  end

  def item_params
    params.permit(:id, :name, :description, :unit_price)
  end
end