require 'rails_helper'

RSpec.describe "get '/my/edit' => 'my#edit'", type: :routing do
  context 'GET /my/edit' do
    subject { get '/my/edit' }
    it { is_expected.to be_routable }
    it { is_expected.to route_to controller: 'my', action: 'edit' }
  end

  context 'edit_my_path' do
    subject { get edit_my_path }
    it { is_expected.to be_routable }
    it { is_expected.to route_to controller: 'my', action: 'edit' }
  end
end
