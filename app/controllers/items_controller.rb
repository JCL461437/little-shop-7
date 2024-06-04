class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    item = Item.new(item_params)
    if item.save
      redirect_to "/merchants/#{item_params[:merchant_id]}/items"
    else
      redirect_to "/merchant/#{item_params[:merchant_id]}/items/new"
      flash[:alert] = "Error"
    end
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
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(item_params[:id])
    if item.update(item_params)
      redirect_to "/merchants/#{merchant.id}/items/#{item.id}"
      flash[:alert] = "Item Information Successfully Updated!"
    else
      redirect_to "/items/#{item.id}/edit"
      flash[:alert] = "Error: Please Fill in All Fields"
    end
  end

  def item_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id)
  end
end