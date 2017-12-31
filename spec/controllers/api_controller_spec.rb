require 'rails_helper'

RSpec.describe ApiController, type: :controller do
  context '#version' do
    context 'response' do
      subject { get :version, format: :text ; response }
      it { is_expected.to have_http_status :ok }
      it { is_expected.to render_template 'api/version' }
    end
  end
end
