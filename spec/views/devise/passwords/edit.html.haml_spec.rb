require 'rails_helper'

RSpec.describe 'devise/passwords/edit.html.haml', type: :view do
  subject { render ; rendered }
  it { is_expected.to have_css '#password_form' }
  it { is_expected.to have_css :h2, text: I18n.t('devise.passwords.edit.change_your_password') }

  # パスワード再発行フォームのチェック
  it { is_expected.to have_css 'form#edit_user_password[action="/users/password"][method="post"]' }
  it { is_expected.to have_css 'form#edit_user_password input[type="hidden"][name="_method"][value="put"]', visible: false }

  #   Password field
  it { is_expected.to have_css 'form#edit_user_password div.form-group.user_password label[for="user_password"]', text: I18n.t('devise.passwords.edit.new_password') }
  it { is_expected.to have_css 'form#edit_user_password div.form-group.user_password input#user_password[name="user[password]"][type="password"]' }

  #     Check bootstrap tag
  it { is_expected.to have_css 'form#edit_user_password div.form-group.user_password label[for="user_password"]' }
  it { is_expected.to have_css 'form#edit_user_password div.form-group.user_password input#user_password.form-control' }

  #   PasswordConfirmation field
  it { is_expected.to have_css 'form#edit_user_password div.form-group.user_password_confirmation label[for="user_password_confirmation"]', text: I18n.t('devise.passwords.edit.confirm_new_password') }
  it { is_expected.to have_css 'form#edit_user_password div.form-group.user_password_confirmation input#user_password_confirmation[name="user[password_confirmation]"][type="password"]' }

  #     Check bootstrap tag
  it { is_expected.to have_css 'form#edit_user_password div.form-group.user_password_confirmation label[for="user_password_confirmation"]' }
  it { is_expected.to have_css 'form#edit_user_password div.form-group.user_password_confirmation input#user_password_confirmation.form-control' }

  #   Submit button
  it { is_expected.to have_css 'form#edit_user_password button#edit_user_password_submit[type="submit"]', text: I18n.t('devise.passwords.edit.change_your_password') }

  #     Check bootstrap tag
  it { is_expected.to have_css 'form#edit_user_password button#edit_user_password_submit.btn.btn-primary.btn-block.btn-lg' }


  # ログインページへのリンクのチェック
  it { is_expected.to have_link I18n.t('devise.shared.links.sign_in'), href: new_user_session_path }

end
