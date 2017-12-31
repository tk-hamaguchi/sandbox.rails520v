require 'rails_helper'

RSpec.describe "root to: 'home#index'", type: :routing do
  context 'GET /' do
    subject { get '/' }
    it { is_expected.to be_routable }
    it { is_expected.to route_to controller: 'home', action: 'index' }
  end

  context 'root_path' do
    subject { get root_path }
    it { is_expected.to be_routable }
    it { is_expected.to route_to controller: 'home', action: 'index' }
  end
end
