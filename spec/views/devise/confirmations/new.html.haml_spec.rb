require 'rails_helper'

RSpec.describe 'devise/confirmations/new.html.haml', type: :view do
  subject { render ; rendered }
  it { is_expected.to have_css '#confirmation_form' }
  it { is_expected.to have_css :h2, text: I18n.t('devise.confirmations.new.resend_confirmation_instructions') }

  # アカウント確認要求フォームのチェック
  it { is_expected.to have_css 'form#new_user_confirmation[action="/users/confirmation"][method="post"]' }

  #   Email field
  it { is_expected.to have_css 'form#new_user_confirmation input#user_email[name="user[email]"][autofocus="autofocus"]' }

  #     Check bootstrap tag
  it { is_expected.to have_css 'form#new_user_confirmation div.form-group.user_email label[for="user_email"]' }
  it { is_expected.to have_css 'form#new_user_confirmation div.form-group.user_email input#user_email.form-control[required="required"]' }

  #   Submit button
  it { is_expected.to have_css 'form#new_user_confirmation button#new_user_confirmation_submit[type="submit"]', text: I18n.t('devise.confirmations.new.resend_confirmation_instructions') }

  #     Check bootstrap tag
  it { is_expected.to have_css 'form#new_user_confirmation button#new_user_confirmation_submit.btn.btn-primary.btn-block.btn-lg' }


  # ログインページへのリンクのチェック
  it { is_expected.to have_link I18n.t('devise.shared.links.sign_in'), href: new_user_session_path }

end
