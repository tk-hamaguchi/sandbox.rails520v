require 'rails_helper'

RSpec.describe "put '/my' => 'my#update'", type: :routing do
  context 'PUT /my' do
    subject { put '/my' }
    it { is_expected.to be_routable }
    it { is_expected.to route_to controller: 'my', action: 'update' }
  end

  context 'my_path' do
    subject { put my_path }
    it { is_expected.to be_routable }
    it { is_expected.to route_to controller: 'my', action: 'update' }
  end
end
