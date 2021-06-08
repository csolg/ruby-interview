# frozen_string_literal: true

module Api::V1
  class UsersController < ::Api::V1::ApplicationController
    skip_before_action :authorize_access_request!, only: [:create, :confirm]

    def create
      result = resolve_action.new(context: {current_user: current_user}).call(params.to_unsafe_h)

      if result.success?
        responds_with_resource(result.value!, status: 201)
      else
        handle_failure(result)
      end
    end

    def confirm
      result = resolve_action.new(context: {current_user: nil}).call(params.to_unsafe_h)

      if result.success?
        render json: { success: true }, status: 202
      else
        head 409
      end
    end

    def resend
      if current_user&.email_credential&.state == 'pending'
        render json: { success: true }, status: 202
      else
        head 409
      end
    end
  end
end
