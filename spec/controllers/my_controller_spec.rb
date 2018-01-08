require 'rails_helper'

RSpec.describe MyController, type: :controller do

  context '#top' do
    subject { get :top }
    context 'by confirmed_user' do
      context 'response' do
        subject { super(); response }
        before { sign_in FactoryBot.create :confirmed_user }
        it { is_expected.to have_http_status :ok }
      end
    end
    context 'by unknown user' do
      context 'response' do
        it { is_expected.to redirect_to new_user_session_path }
      end
    end
  end

  context '#edit' do
    subject { get :edit }
    context 'by confirmed_user' do
      context 'response' do
        subject { super(); response }
        before { sign_in FactoryBot.create :confirmed_user }
        it { is_expected.to have_http_status :ok }
      end
    end
    context 'by unknown user' do
      context 'response' do
        it { is_expected.to redirect_to new_user_session_path }
      end
    end
  end

  context '#update' do
    subject { put :update }
    let(:user_params) { double(ActionController::Parameters) }

    context 'with valid params' do
      before { allow(controller).to receive(:user_params).and_return(user_params) }
      context 'by confirmed_user' do
        let(:user) { FactoryBot.create :confirmed_user }
        let(:update_result) { true }
        before do
          allow(controller).to receive(:current_user).and_return(user)
          allow(user).to receive(:update).and_return(update_result)
          sign_in user
        end
        context 'response' do
          subject { super(); response }
          it { is_expected.to redirect_to edit_my_path }
        end
        context 'flash[:notice]' do
          subject { super(); flash[:notice] }
          it { is_expected.to eq I18n.t('applicationcontroller.my.update.flash.updated') }
        end
        context 'current_user' do
          it {
            expect(user).to receive(:update).with(user_params)
            subject
          }
        end
      end
      context 'by unknown_user' do
        context 'response' do
          subject { super(); response }
          it { is_expected.to redirect_to new_user_session_path }
        end
        context 'flash[:alert]' do
          subject { super(); flash[:alert] }
          it { is_expected.to eq I18n.t('devise.failure.unauthenticated') }
        end
      end
    end

    context 'with invalid params' do
      context 'by confirmed_user' do
        let(:user) { FactoryBot.create :confirmed_user }
        let(:update_result) { true }
        before do
          allow(controller).to receive(:user_params).and_raise(ActionController::ParameterMissing.new({}))
          sign_in user
        end

        it { expect{subject}.to raise_error ActionController::ParameterMissing }
      end
    end

    context 'with invalid user_params' do
      context 'by confirmed_user' do
        let(:user) { FactoryBot.create :confirmed_user }
        let(:update_result) { false }
        before do
          allow(controller).to receive(:user_params).and_return(user_params)
          allow(controller).to receive(:current_user).and_return(user)
          allow(user).to receive(:update).and_return(update_result)
          sign_in user
        end

        context 'response' do
          subject { super(); response }
          it { is_expected.to render_template :edit }
        end
      end
    end
  end

  context '#user_params' do
    let(:params) { {} }
    before do
      controller_params = ActionController::Parameters.new params
      allow(controller).to receive(:params).and_return(controller_params)
    end
    subject { controller.send(:user_params) }
    context 'params = {}' do
      it { expect{subject}.to raise_error ActionController::ParameterMissing }
    end
    context 'params = { user: {} }' do
      let(:params) { { user: {} } }
      it { expect{subject}.to raise_error ActionController::ParameterMissing }
    end
    context 'params = { user: { name: "hoge" } }' do
      let(:params) { { user: { name: 'hoge' } } }
      it { is_expected.to eq ActionController::Parameters.new(params[:user]).permit! }
    end
    context 'params = { user: { id: 1, name: "hoge" } }' do
      let(:params) { { user: { id: 1, name: 'hoge' } } }
      it { is_expected.to eq ActionController::Parameters.new({ name: 'hoge' }).permit! }
    end
    context 'params = { user: { name: "hoge", password: "" } }' do
      let(:params) { { user: { name: 'hoge', password: '' } } }
      it { is_expected.to eq ActionController::Parameters.new({ name: 'hoge' }).permit! }
    end
    context 'params = { user: { name: "hoge", password: "fuga" } }' do
      let(:params) { { user: { name: 'hoge', password: 'fuga' } } }
      it { is_expected.to eq ActionController::Parameters.new(params[:user]).permit! }
    end
    context 'params = { user: { name: "hoge", password: "fuga", password_confirmation: "puki" } }' do
      let(:params) { { user: { name: 'hoge', password: 'fuga', password_confirmation: 'puki' } } }
      it { is_expected.to eq ActionController::Parameters.new(params[:user]).permit! }
    end
  end
end
