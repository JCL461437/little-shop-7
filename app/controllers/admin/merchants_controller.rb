class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    @enabled_merchants = enabled_merchants
    @disabled_merchants = disabled_merchants
  end

  def show
    @merchant = Merchant.find(params[:id])
  end
end
