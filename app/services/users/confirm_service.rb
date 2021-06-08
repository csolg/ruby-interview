# frozen_string_literal: true

module Users
  class ConfirmService
    def call(params)
      email_credential = EmailCredential.find_by(confirmation_token: params[:token])

      if email_credential
        if email_credential.state == 'pending'
          if email_credential.confirmation_expired?
            email_credential.confirm!
          else
            raise 'Confirmation token was expired!'
          end
        else
          raise 'Email has already confirmed!'
        end
      else
        raise 'Confirmation token not found!'
      end

      email_credential
    end
  end
end
