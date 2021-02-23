class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :show_not_found_errors
  rescue_from Apipie::ParamMissing, with: :show_invalid_parameters

  def show_not_found_errors(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def show_invalid_parameters(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end
end
