require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  context '#index' do
    context 'response' do
      subject { get :index ; response }
      it { is_expected.to have_http_status :ok }
    end
  end
end
