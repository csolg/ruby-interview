require 'rails_helper'

RSpec.describe Api::V1::UsersController do
  describe '#confirm' do
    let(:email_credential) { create :email_credential }
    let(:user) { email_credential.user }

    before do
      get :confirm, params: { token: user.email_credential.confirmation_token }
    end

    it { expect(response).to be_success }
    it { expect(EmailCredential.find(email_credential.id).confirmed_at).to_not be_nil }
  end
end
