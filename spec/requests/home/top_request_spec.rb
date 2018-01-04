require 'rails_helper'

RSpec.describe 'GET /', type: :request do
  subject { get '/' }
  context 'with unknown user' do
    it { is_expected.to render_template :application }
    it { is_expected.to render_template partial: 'layouts/_header' }

    it { is_expected.to_not render_template :grid_system }
    it { is_expected.to_not render_template partial: 'layouts/_side_menu_items' }
    it { is_expected.to_not render_template partial: 'layouts/_footer' }

    it { is_expected.to render_template 'home/index' }

    context 'response' do
      subject { get '/'; response }
      it { is_expected.to have_http_status :ok }
    end
  end

  context 'with signed in user' do
    before { sign_in FactoryBot.create :confirmed_user }
    it { is_expected.to redirect_to my_path }
  end
end
