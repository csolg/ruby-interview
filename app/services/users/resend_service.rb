# frozen_string_literal: true

module Users
  class ResendService
    def call(user)
      if user&.email_credential
        if user.email_credential.state == 'pending'
          user.email_credential.resend_confirmation_email
        else
          raise 'Email has already confirmed.'
        end
      else
        raise 'Please, sign in'
      end

      user
    end
  end
end
