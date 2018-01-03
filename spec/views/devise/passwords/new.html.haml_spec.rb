require 'rails_helper'

RSpec.describe 'devise/passwords/new.html.haml', type: :view do
  subject { render ; rendered }
  it { is_expected.to have_css '#password_form' }
  it { is_expected.to have_css :h2, text: I18n.t('devise.shared.links.forgot_your_password') }

  # パスワード再発行要求フォームのチェック
  it { is_expected.to have_css 'form#new_user_password[action="/users/password"][method="post"]' }

  #   Email field
  it { is_expected.to have_css 'form#new_user_password input#user_email[name="user[email]"][placeholder="' + User.human_attribute_name(:email) + '"]' }

  #     Check bootstrap tag
  it { is_expected.to_not have_css 'form#new_user_password div.form-group.user_email label[for="user_email"]' }
  it { is_expected.to have_css 'form#new_user_password div.form-group.user_email input#user_email.form-control' }

  #   Submit button
  it { is_expected.to have_css 'form#new_user_password button#new_user_password_submit[type="submit"]', text: I18n.t('devise.passwords.new.send_me_reset_password_instructions') }

  #     Check bootstrap tag
  it { is_expected.to have_css 'form#new_user_password button#new_user_password_submit.btn.btn-primary.btn-block.btn-lg' }


  # ログインページへのリンクのチェック
  it { is_expected.to have_link I18n.t('devise.shared.links.sign_in'), href: new_user_session_path }

end
