require 'rails_helper'

RSpec.describe "get '/my' => 'my#top", type: :routing do
  context 'GET /my' do
    subject { get '/my' }
    it { is_expected.to be_routable }
    it { is_expected.to route_to controller: 'my', action: 'top' }
  end

  context 'edit_my_path' do
    subject { get my_path }
    it { is_expected.to be_routable }
    it { is_expected.to route_to controller: 'my', action: 'top' }
  end
end
