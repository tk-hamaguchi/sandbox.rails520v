require 'rails_helper'

RSpec.describe 'GET /my', type: :request do
  subject { get '/my' }
  context 'with unknown user' do
    it { is_expected.to redirect_to new_user_session_path }
  end

  context 'with signed in user' do
    before { sign_in FactoryBot.create :confirmed_user }

    it { is_expected.to render_template :application }
    it { is_expected.to render_template partial: 'layouts/_header' }

    it { is_expected.to render_template :grid_system }
    it { is_expected.to_not render_template partial: 'layouts/_side_menu_items' }
    it { is_expected.to render_template partial: 'layouts/_footer' }

    it { is_expected.to render_template :my }
    it { is_expected.to render_template partial: 'layouts/_alerts' }

    it { is_expected.to render_template 'my/top' }

    context 'response' do
      subject { get '/my'; response }
      it { is_expected.to have_http_status :ok }
    end
  end
end
