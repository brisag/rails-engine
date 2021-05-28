class Api::V1::ItemsMerchantController < ApplicationController
  def index
    items = Item.find(params[:item_id])
    render json: MerchantSerializer.new(items.merchant)
  end
end
