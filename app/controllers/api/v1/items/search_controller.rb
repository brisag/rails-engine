class Api::V1::Items::SearchController < ApplicationController
  def index

    item = if params[:name]
             Item.search_criteria(params[:name].downcase).first
           else
             Item.min_max_search(params[:max_price], params[:min_price])
           end

    render json: item.nil? ? { data: {} } : ItemSerializer.new(item)
  end

  # sad path, min_price less than 0 | AssertionError: expected 200 to equal 400
  # sad path, cannot send name and min_price | AssertionError: expected 200 to equal 400
  # sad path, max_price less than 0 | AssertionError: expected 200 to equal 400
  # sad path, cannot send name and max_price | AssertionError: expected 200 to equal 400

end
