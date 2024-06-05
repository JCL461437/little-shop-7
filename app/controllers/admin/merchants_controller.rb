class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all 
    #Best practice is to do 1 variable here. The below variables are unnecessary - just call the model methods(.enabled_merchants) on @merchants in the view
    #let's refactor in another PR tomorrow.
    @enabled_merchants = Merchant.enabled_merchants 
    @disabled_merchants = Merchant.disabled_merchants
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def new
    @merchant = Merchant.new
  end
  
  def create
    @merchant = Merchant.new(name: params[:merchant][:name])
    @merchant.status = :disabled #why is this here? Default takes care of it

    if @merchant.save
      redirect_to admin_merchants_path, notice: 'Merchant was successfully created.'
    else
      #Not Working, needs to be refactored
      flash.now[:notice] = 'Please fill out all the required fields.'
      render :new
    end
  end

  def update 
    @merchant = Merchant.find(params[:id])
    if params[:status]
      @merchant.update(status: params[:status])
      notice = "Merchant has been #{params[:status]}."
      redirect_to admin_merchants_path, notice: notice
    elsif 
      @merchant.update(name: params[:merchant][:name])
      redirect_to admin_merchant_path(@merchant) 
      flash[:notice] = "Information has been successfully updated"
    end
  end
end