# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_error

  private

  def not_found_error
    render json: { error: 'Not found' }, status: :not_found
  end
end
