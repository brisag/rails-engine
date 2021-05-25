class Api::V1::Revenue::MerchantsController < ApplicationController
  def show
    merchant = Merchant.find(params[:id])
    render json: MerchantRevenueSerializer.new(merchant)
  end
end
  # def merchants
  #   if params[:quantity].present?
  #   render
  # else
  #
  # end
  #
  # def items
  # end
