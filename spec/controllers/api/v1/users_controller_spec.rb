require 'rails_helper'

RSpec.describe Api::V1::UsersController do

  describe '#confirm' do
    let(:user) { email_credential.user }

    context 'when token is ok' do
      let(:email_credential) { create :email_credential, state: :pending }

      before do
        get :confirm, params: { token: email_credential.confirmation_token }

        email_credential.reload
      end

      it { expect(response).to be_success }
      it { expect(email_credential.confirmed_at).to_not be_nil }
      it { expect(email_credential.state).to eq 'active' }
    end

    context 'when email_credential is active' do
      let(:email_credential) { create :email_credential, state: :active }
      let(:old_confirmed_at) { email_credential.confirmed_at }

      before do
        get :confirm, params: { token: email_credential.confirmation_token }

        email_credential.reload
      end

      it { expect(response.status).to eq 409 }
    end

    context 'when token is invalid' do
      let(:email_credential) { create :email_credential, state: :pending }

      before do
        get :confirm, params: { token: '123' }

        email_credential.reload
      end

      it { expect(response.status).to eq 409 }
    end

    context 'when token was expired' do
      let(:email_credential) { create :email_credential, state: :pending, confirmed_at: nil }

      before do
        email_credential.update(confirmation_sent_at: 3.days.ago)

        get :confirm, params: { token: email_credential.confirmation_token }

        email_credential.reload
      end


      it { expect(response.status).to eq 409 }
      it { expect(email_credential.confirmed_at).to be_nil }
      it { expect(email_credential.state).to eq 'pending' }
    end
  end

  # describe '#resend' do
  #   context 'when user signed in' do
  #     let(:user) { email_credential.user }

  #     before do
  #       payload = { sub: user.id }
  #       session = JWTSessions::Session.new(payload: payload)
  #       tokens = session.login
  #       request.headers[JWTSessions.access_header] = "Bearer #{tokens[:access]}"

  #       get :resend

  #       email_credential.reload
  #     end

  #     context 'when state is active' do
  #       let(:email_credential) { create :email_credential, state: :active }

  #       it { expect(response).to be_failure }
  #       it { expect { get :resend, params: { email: email_credential.email } }.to change { ActionMailer::Base.deliveries.count }.by(0) }
  #     end

  #     context 'when state is pending' do
  #       let(:email_credential) { create :email_credential, state: :pending }

  #       it { expect(response).to be_success }
  #       it { expect(email_credential.confirmed_at).to be_nil }
  #       it { expect { get :resend, params: { email: email_credential.email } }.to change { ActionMailer::Base.deliveries.count }.by(1) }
  #     end
  #   end

  #   context 'when user didn\'t sign in' do
  #     before do
  #       get :resend
  #     end

  #     it { expect(response).to be_failure }
  #   end
  # end
end
