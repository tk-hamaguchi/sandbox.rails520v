require 'rails_helper'

RSpec.describe 'devise/mailer/confirmation_instructions.html.haml', type: :view do
  subject { render ; rendered }
  let(:resource) { FactoryBot.create(:user, email: 'dummy@example.com') }
  let(:token) { 'dummytoken' }
  before do
    assign :resource, resource
    assign :token,    token
  end

  it { is_expected.to have_css :p, text: t('devise.mailer.confirmation_instructions.greeting', recipient: 'dummy@example.com') }
  it { is_expected.to have_css :p, text: t('devise.mailer.confirmation_instructions.instruction') }
  it { is_expected.to have_link t('devise.mailer.confirmation_instructions.action'), href: user_confirmation_url(confirmation_token: 'dummytoken') }
end
