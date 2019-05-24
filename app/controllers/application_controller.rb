class ApplicationController < ActionController::API
  ActionController::Parameters.permit_all_parameters = true

  rescue_from RailsParam::Param::InvalidParameterError do |err|
    render json: err, status: :bad_request
  end
end
