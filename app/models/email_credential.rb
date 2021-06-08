# frozen_string_literal: true

class EmailCredential < ApplicationRecord
  has_secure_password

  belongs_to :user

  has_secure_token :confirmation_token

  after_create :send_confirmation_email

  def confirm!
    update confirmed_at: Time.now, state: 'active'
  end

  def confirmation_expired?
    confirmation_sent_at + 2.days > Time.now
  end

  private

  def send_confirmation_email
    UserMailer.send_confirmation_email(user).deliver_now
  end
end
