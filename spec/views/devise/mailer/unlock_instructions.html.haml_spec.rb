require 'rails_helper'

RSpec.describe 'devise/mailer/unlock_instructions.html.haml', type: :view do
  subject { render ; rendered }
  let(:resource) { FactoryBot.create(:user, email: 'dummy@example.com') }
  let(:token) { 'dummytoken' }
  before do
    assign :resource, resource
    assign :token,    token
  end

  it { is_expected.to have_css :p, text: t('devise.mailer.unlock_instructions.greeting', recipient: 'dummy@example.com') }
  it { is_expected.to have_css :p, text: t('devise.mailer.unlock_instructions.message') }
  it { is_expected.to have_css :p, text: t('devise.mailer.unlock_instructions.instruction') }
  it { is_expected.to have_link t('devise.mailer.unlock_instructions.action'), href: user_unlock_url(unlock_token: 'dummytoken') }
end
