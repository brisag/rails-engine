class Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    # binding.pry
    if params[:quantity].to_i.present?
      render json: MerchantsHighestRevenueSerializer.new(Merchant.merchants_with_most_revenue(params[:quantity]))
    end
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: MerchantRevenueSerializer.new(merchant)
  end
end
