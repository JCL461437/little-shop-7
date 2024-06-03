class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
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
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
    
    if @item.update!(item_params)
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
      flash[:notice] = "Item Information Successfully Updated!"
    else
      redirect_to "merchants/#{@merchant.id}/items/#{@item.id}/edit"
      flash[:alert] = "Error: Please Fill in All Fields"
    end
  end
  
  private

  def item_params
    params.permit(:id, :name, :description, :unit_price)
  end
end