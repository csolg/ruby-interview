# frozen_string_literal: true

module Api::V1
  module Users
    class ConfirmAction < ::Api::V1::BaseAction
      def call(input)
        confirm(input)
      end

      private

      def confirm(input)
        Try(active_record_common_errors) do
          ::Users::ConfirmService.new.call(input)
        end.to_result
      end
    end
  end
end
