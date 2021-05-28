class Api::V1::Items::SearchController < ApplicationController
  before_action :validate_params

  def index
    item = if params[:name]
             Item.search_criteria(params[:name].downcase).first
           else
             Item.min_max_search(params[:max_price], params[:min_price])
           end
    render json: item.nil? ? { data: {} } : ItemSerializer.new(item)
  end

private

  def validate_params
    if params[:name].blank? && params[:min_price].blank? && params[:max_price].blank?
      render json: { error: '400 Bad Request' }, status: :bad_request
    elsif ((params[:min_price] || params[:max_price]) && params[:name]) || (params[:min_price].to_i < 0 || params[:max_price].to_i < 0)
      render json: { error: '400 Bad Request' }, status: :bad_request
    elsif (params[:min_price] && params[:max_price] && params[:min_price] > params[:max_price])
      render json: { error: '400 Bad Request' }, status: :bad_request
    end
  end
end
