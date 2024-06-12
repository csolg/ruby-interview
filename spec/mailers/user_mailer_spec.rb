require 'rails_helper'

RSpec.describe UserMailer do

  def get_message_part (mail, content_type)
    mail.body.parts.find { |p| p.content_type.match content_type }.body.raw_source
  end

  describe 'send_confirmation_email' do
    let(:email_credential) { create :email_credential }
    let(:mail) { UserMailer.send_confirmation_email(email_credential.user) }

    it { expect(mail.subject).to eq 'The confirmation email' }
    it { expect(mail.to).to eq [email_credential.email] }
    it { expect(EmailCredential.find(email_credential.id).confirmation_sent_at).to_not be_nil }

    context 'when format is html' do
      let(:part) { get_message_part mail, /html/ }

      it { expect(part).to include("<a href='http://example.com/users/confirm?token=#{email_credential.confirmation_token}'>Confirm</a>") }
    end

    context 'when format is txt' do
      let(:part) { get_message_part mail, /plain/ }

      it { expect(part).to include("http://example.com/users/confirm?token=#{email_credential.confirmation_token}") }
    end
  end
end
