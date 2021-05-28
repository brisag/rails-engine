class Api::V1::Revenue::UnshippedController < ApplicationController
  def index
    if params[:quantity].to_i.present?
      render json: UnshippedSerializer.new(Invoice.unshipped_revenue(params[:quantity]))
    end
  end
end
