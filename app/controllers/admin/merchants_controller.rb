class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    @enabled_merchants = Merchant.enabled_merchants
    @disabled_merchants = Merchant.disabled_merchants
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def update 
    @merchant = Merchant.find(params[:id])
    if params[:status] == "enabled"
      @merchant.enabled!
      notice = 'Merchant has been enabled.'
    elsif params[:status] == "disabled"
      @merchant.disabled!
      notice = 'Merchant has been disabled.'
    end
    redirect_back fallback_location: admin_merchants_path, notice: notice
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
