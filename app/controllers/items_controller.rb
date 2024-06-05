class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    # @items = @merchant.items
    @enabled_items = @merchant.items.enabled_items 
    @disabled_items = @merchant.items.disabled_items
    # require 'pry'; binding.pry
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(item_params[:id])
  end

  def update
    require 'pry'; binding.pry
    @merchant = Merchant.find(params[:id])
    @item = @merchant.items.find(params[:id])
    # require 'pry'; binding.pry
    if params[:status]
      @item.update(status: params[:status])
      redirect_to "/merchants/#{@merchant.id}/items"
    elsif item.update(item_params)
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
      flash[:notice] = "Item Information Successfully Updated!"
    else
      redirect_to "/items/#{@item.id}/edit"
      flash[:alert] = "Error: Please Fill in All Fields"
    end
  end

  def item_params
    params.permit(:id, :name, :description, :unit_price)
  end
end