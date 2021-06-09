# frozen_string_literal: true

module Api::V1
  module Users
    class ResendAction < ::Api::V1::BaseAction
      def call(input)
        resend
      end

      private

      def resend
        Try([RuntimeError]) do
          ::Users::ResendService.new.call(@current_user)
        end.to_result
      end
    end
  end
end
