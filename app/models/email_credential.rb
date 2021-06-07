# frozen_string_literal: true

class EmailCredential < ApplicationRecord
  has_secure_password

  belongs_to :user

  has_secure_token :confirmation_token

  after_create :send_confirmation_email

  private

  def send_confirmation_email
    UserMailer.send_confirmation_email(user).deliver_now
  end
end
