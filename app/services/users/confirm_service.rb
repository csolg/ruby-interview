# frozen_string_literal: true

module Users
  class ConfirmService
    def call(params)
      token = params[:token]
      email_credential = EmailCredential.find_by(confirmation_token: token)

      if email_credential
        email_credential.update confirmed_at: Time.now, state: 'active'
      end
    end
  end
end
