require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  context '#index' do
    context 'response' do
      subject { get :index ; response }
      context 'with unknown user' do
        it { is_expected.to have_http_status :ok }
      end
      context 'with signed in user' do
        before { sign_in FactoryBot.create :confirmed_user }
        it { is_expected.to redirect_to my_path }
      end
    end
  end
end
