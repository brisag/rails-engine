class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_not_found
  # rescue_from ActiveRecord::RecordInvalid, with: :invalid_request


  def record_not_found
    render json: { error: '404 Not Found' }, status: :not_found
  end

  def record_bad_request
    render json: { error: '400 Bad Request' }, status: :bad_request
  end

  # def missing_attribute_request
  #   render json: { error: '404 Bad Request' }, status: :invalid_request
  # end
end
