class ApplicationController < ActionController::API
  def error_handler(error_message, status = :bad_request)
    response_hash = ErrorSerializer.format_error(error_message)
    render json: response_hash, status: status
  end
end
