require 'rails_helper'

RSpec.describe Api::V1::UsersController do
  describe '#confirm' do
    let(:email_credential) { create :email_credential, state: :pending }
    let(:user) { email_credential.user }

    before do
      get :confirm, params: { token: user.email_credential.confirmation_token }

      email_credential.reload
    end

    it { expect(response).to be_success }
    it { expect(email_credential.confirmed_at).to_not be_nil }
    it { expect(email_credential.state).to eq 'active' }
  end
end
