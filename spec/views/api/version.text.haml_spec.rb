require 'rails_helper'

RSpec.describe 'api/version.text.haml', type: :view do
  before do
    assign :version, double(Rails520v::VERSION, app_version: '98.765.43.pre21', db_version: '20991231012345')
  end
  subject { render ; rendered }
  context 'without params' do
    it { is_expected.to match /^APP_VERSION: 98.765.43.pre21$/ }
    it { is_expected.to_not match /^DB_VERSION:/ }
  end

  context 'with params = { details: true }' do
    before do
      allow(view).to receive(:params).and_return({ details: true })
    end
    it { is_expected.to match /^APP_VERSION: 98.765.43.pre21$/ }
    it { is_expected.to match /^DB_VERSION:  20991231012345$/ }
  end
end
