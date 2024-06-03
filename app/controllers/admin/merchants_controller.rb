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
    redirect_to admin_merchant_path, notice: notice
  end
end
