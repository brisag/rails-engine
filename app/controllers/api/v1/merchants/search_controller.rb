class Api::V1::Merchants::SearchController < ApplicationController
  def index
    if params[:name].present?
      merchants = Merchant.search_criteria(params[:name].downcase)
      render json: MerchantSerializer.new(merchants)
    end 
  end
end
