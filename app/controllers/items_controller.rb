class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @enabled_items = @merchant.items.enabled_items 
    @disabled_items = @merchant.items.disabled_items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
    if params[:status]
      @item.update(status: params[:status])
      redirect_to "/merchants/#{@merchant.id}/items"
    elsif @item.update(name: params[:name], description: params[:description], unit_price: params[:unit_price])
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
      flash[:notice] = "Item Information Successfully Updated!"
    else
      redirect_to "/items/#{@item.id}/edit"
      flash[:alert] = "Error: Please Fill in All Fields"
    end
  end
end