require 'rails_helper'

RSpec.describe 'devise/unlocks/new.html.haml', type: :view do
  subject { render ; rendered }
  it { is_expected.to have_css '#unlock_form' }
  it { is_expected.to have_css :h2, text: I18n.t('devise.unlocks.new.resend_unlock_instructions') }

  # アカウント確認要求フォームのチェック
  it { is_expected.to have_css 'form#new_user_unlock[action="/users/unlock"][method="post"]' }

  #   Email field
  it { is_expected.to have_css 'form#new_user_unlock input#user_email[name="user[email]"][autofocus="autofocus"]' }

  #     Check bootstrap tag
  it { is_expected.to have_css 'form#new_user_unlock div.form-group.user_email label[for="user_email"]' }
  it { is_expected.to have_css 'form#new_user_unlock div.form-group.user_email input#user_email.form-control[required="required"]' }

  #   Submit button
  it { is_expected.to have_css 'form#new_user_unlock button#new_user_unlock_submit[type="submit"]', text: I18n.t('devise.unlocks.new.resend_unlock_instructions') }

  #     Check bootstrap tag
  it { is_expected.to have_css 'form#new_user_unlock button#new_user_unlock_submit.btn.btn-primary.btn-block.btn-lg' }


  # ログインページへのリンクのチェック
  it { is_expected.to have_link I18n.t('devise.shared.links.sign_in'), href: new_user_session_path }

end
