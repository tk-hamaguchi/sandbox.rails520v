require 'rails_helper'

RSpec.describe 'devise/mailer/reset_password_instructions.html.haml', type: :view do
  subject { render ; rendered }
  let(:resource) { FactoryBot.create(:user, email: 'dummy@example.com') }
  let(:token) { 'dummytoken' }
  before do
    assign :resource, resource
    assign :token,    token
  end

  it { is_expected.to have_css :p, text: t('devise.mailer.reset_password_instructions.greeting', recipient: 'dummy@example.com') }
  it { is_expected.to have_css :p, text: t('devise.mailer.reset_password_instructions.instruction') }
  it { is_expected.to have_link t('devise.mailer.reset_password_instructions.action'), href: edit_user_password_url(reset_password_token: 'dummytoken') }
  it { is_expected.to have_css :p, text: t('devise.mailer.reset_password_instructions.instruction_2') }
  it { is_expected.to have_css :p, text: t('devise.mailer.reset_password_instructions.instruction_3') }
end
