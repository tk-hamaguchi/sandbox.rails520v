require 'rails_helper'

RSpec.describe 'devise/mailer/password_change.html.haml', type: :view do
  subject { render ; rendered }
  let(:resource) { FactoryBot.create(:user, email: 'dummy@example.com') }
  before do
    assign :resource, resource
  end

  it { is_expected.to have_css :p, text: t('devise.mailer.password_change.greeting', recipient: 'dummy@example.com') }
  it { is_expected.to have_css :p, text: t('devise.mailer.password_change.message') }
end
