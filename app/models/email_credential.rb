# frozen_string_literal: true

class EmailCredential < ApplicationRecord
  include AASM

  has_secure_password

  belongs_to :user

  has_secure_token :confirmation_token

  after_create :send_confirmation_email

  def confirmation_expired?
    confirmation_sent_at + 2.days > Time.now
  end

  def resend_confirmation_email
    regenerate_confirmation_token
    UserMailer.send_confirmation_email(user).deliver_now
  end

  def send_confirmation_email
    UserMailer.send_confirmation_email(user).deliver_now
  end

  def update_confirmed_at_to_now
    update confirmed_at: Time.now
  end

  aasm column: 'state' do
    state :pending, initial: true
    state :active

    event :confirm, after: :update_confirmed_at_to_now do
      transitions from: :pending, to: :active
    end
  end
end
