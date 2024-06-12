class UserMailer < ApplicationMailer
  default from: "from@example.com"

  def send_confirmation_email user
    @user = user

    user.email_credential.update(confirmation_sent_at: Time.now)

    mail(to: user.email_credential.email, subject: 'The confirmation email')
  end
end
