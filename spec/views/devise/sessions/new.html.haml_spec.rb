require 'rails_helper'

RSpec.describe 'devise/sessions/new.html.haml', type: :view do
  subject { render ; rendered }

  before do
    stub_template 'layouts/_alerts.html.haml' => 'ALERTS_CONTENTS'
  end

  it { is_expected.to have_css '#login_form' }
  it { is_expected.to have_css :h1, text: I18n.t('app_name') }

  # render partial: '/layouts/alerts'
  it { is_expected.to have_css '#login_form', text: 'ALERTS_CONTENTS' }

  # ログインフォームのチェック
  it { is_expected.to have_css 'form#new_user_session[action="/users/sign_in"][method="post"]' }

  #   Email field
  it { is_expected.to_not have_css 'form#new_user_session label[for="user_email"]' }
  it { is_expected.to have_css 'form#new_user_session input#user_email[name="user[email]"][type="email"][placeholder="' + User.human_attribute_name(:email) + '"]' }

  #     Check bootstrap tag
  it { is_expected.to have_css 'form#new_user_session div.form-group.user_email input#user_email.form-control' }

  #   Password field
  it { is_expected.to_not have_css 'form#new_user_session label[for="user_password"]' }
  it { is_expected.to have_css 'form#new_user_session input#user_password[name="user[password]"][type="password"][placeholder="' + User.human_attribute_name(:password) + '"]' }

  #     Check bootstrap tag
  it { is_expected.to have_css 'form#new_user_session div.form-group.user_password input#user_password.form-control' }

  #   RememberMe field
  it { is_expected.to have_css 'form#new_user_session label[for="user_remember_me"]' }
  it { is_expected.to have_css 'form#new_user_session input#user_remember_me[name="user[remember_me]"][type="checkbox"]' }

  #     Check bootstrap tag
  it { is_expected.to have_css 'form#new_user_session div.form-check.user_remember_me input#user_remember_me.form-check-input' }
  it { is_expected.to have_css 'form#new_user_session div.form-check.user_remember_me label.form-check-label[for="user_remember_me"]', text: User.human_attribute_name(:remember_me) }

  #   Submit button
  it { is_expected.to have_css 'form#new_user_session button#new_user_session_submit[type="submit"]', text: I18n.t('devise.sessions.new.sign_in') }

  #     Check bootstrap tag
  it { is_expected.to have_css 'form#new_user_session button#new_user_session_submit.btn.btn-primary.btn-block.btn-lg' }


  # パスワード再発行要求ページへのリンクのチェック
  it { is_expected.to have_link I18n.t('devise.shared.links.forgot_your_password'), href: new_user_password_path }

end
