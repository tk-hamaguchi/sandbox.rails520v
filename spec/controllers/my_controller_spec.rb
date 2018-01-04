require 'rails_helper'

RSpec.describe MyController, type: :controller do

  context '#top' do
    subject { get :top }
    it { is_expected.to render_template :my }
    context 'response' do
      subject { get :top; response }
      context 'with signed in user' do
        before { sign_in FactoryBot.create :confirmed_user }
        it { is_expected.to have_http_status :ok }
      end
      context 'with unknown user' do
        it { is_expected.to redirect_to new_user_session_path }
      end
    end
  end

end
