require 'rails_helper'

RSpec.describe "get '/version', defaults: { format: :text }", type: :routing do
  context 'GET /version' do
    subject { get '/version' }
    it { is_expected.to be_routable }
    it { is_expected.to route_to controller: 'api', action: 'version', format: :text }
  end

  context 'GET /version?details=true' do
    subject { get '/version?details=true' }
    it { is_expected.to be_routable }
    it { is_expected.to route_to controller: 'api', action: 'version', format: :text, details: 'true' }
  end

  context 'version_path' do
    subject { get version_path }
    it { is_expected.to be_routable }
    it { is_expected.to route_to controller: 'api', action: 'version', format: :text }
  end
end
