class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    @enabled_merchants = Merchant.enabled_merchants
    @disabled_merchants = Merchant.disabled_merchants
  end

  def show
    @merchant = Merchant.find(params[:id])
  end
  
  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    
    if @merchant.update(merchant_params)
      flash[:notice] = "Information has been successfully updated"
  
      if params[:status] == "enabled"
        @merchant.enabled!
        flash[:notice] = 'Merchant has been enabled.'
      elsif params[:status] == "disabled"
        @merchant.disabled!
        flash[:notice] = 'Merchant has been disabled.'
      end
  
      redirect_to admin_merchant_path(@merchant)
    else
      flash[:alert] = "There was a problem updating the merchant."
      render :edit
    end
  end
  

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.new(merchant_params)
    @merchant.status = :disabled

    if @merchant.save
      redirect_to admin_merchants_path, notice: 'Merchant was successfully created.'
    else
      # Not Working, needs to be refactored
      flash.now[:notice] = 'Please fill out all the required fields.'
      render :new
    end
  end

  private
  def merchant_params
    params.require(:merchant).permit(:name)
  end
end
