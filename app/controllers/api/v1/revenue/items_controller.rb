class Api::V1::Revenue::ItemsController < ApplicationController
  def index
    # binding.pry
    if params[:quantity].to_i.present?
      render json: ItemRevenueSerializer.new(Item.ranked_by_revenue(params[:quantity]))
    end
  end
end
