require 'rails_helper'

RSpec.describe EmailCredential do
  describe 'confirmation email' do
    context 'when email_credential created' do
      it { expect { create :email_credential }.to change { ActionMailer::Base.deliveries.count }.by(1) }
    end
  end
end
