require 'rails_helper'

RSpec.describe 'GET /users/sign_in', type: :request do
  subject { get '/users/sign_in' }
  context 'with unknown user' do
    it { is_expected.to render_template :application }
    it { is_expected.to_not render_template partial: 'layouts/_header' }

    it { is_expected.to render_template :center_middle }
    it { is_expected.to render_template partial: 'layouts/_footer' }

    it { is_expected.to render_template :devise }

    it { is_expected.to render_template 'devise/sessions/new' }
    it { is_expected.to render_template partial: 'layouts/_alerts' }

    context 'response' do
      subject { get '/users/sign_in'; response }
      it { is_expected.to have_http_status :ok }
    end

  end

  context 'with signed in user' do
    before { sign_in FactoryBot.create :confirmed_user }
    it { is_expected.to redirect_to root_path }
  end
end
