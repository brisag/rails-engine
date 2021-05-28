class Api::V1::Revenue::ItemsController < ApplicationController
#   def index
#     # binding.pry
#     if params[:quantity].to_i.present?
#       render json: ItemRevenueSerializer.new(Item.ranked_by_revenue(params[:quantity]))
#     end
#   end
# end
#

def index
  if params[:quantity].nil? || params[:quantity].to_i > 0
    render json: ItemRevenueSerializer.new(Item.ranked_by_revenue(quantity))
  else
    render json: { error: '400 Bad Request' }, status: :bad_request
  end
end

private

def quantity
  params.fetch(:quantity, 10).to_i
end
end
