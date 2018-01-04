require 'rails_helper'

RSpec.describe 'GET /users/confirmation/new', type: :request do
  subject { get '/users/confirmation/new' }
  it { is_expected.to render_template :application }
  it { is_expected.to_not render_template partial: 'layouts/_header' }

  it { is_expected.to render_template :center_middle }
  it { is_expected.to render_template partial: 'layouts/_footer' }

  it { is_expected.to render_template :devise }

  it { is_expected.to render_template 'devise/confirmations/new' }

  context 'response' do
    subject { get '/users/confirmation/new'; response }
    it { is_expected.to have_http_status :ok }
  end
end
