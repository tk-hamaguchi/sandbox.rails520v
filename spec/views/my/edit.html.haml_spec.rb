require 'rails_helper'

RSpec.describe 'my/edit.html.haml', type: :view do
  let(:user) { FactoryBot.create :confirmed_user }
  subject { render ; rendered }
  before do
    allow(view).to receive(:current_user).and_return(user)
  end

  # パンくずリストのチェック
  it { is_expected.to have_link I18n.t('page_name.home'), href: root_path }
  it { is_expected.to have_css "nav[aria-label='breadcrumb'] a[href='/']", text: I18n.t('page_name.home') }

  # アカウント設定フォームのチェック
  it { is_expected.to have_css "form#edit_user_#{user.id}[action='/my'][method='post']" }
  it { is_expected.to have_css "form#edit_user_#{user.id} input[type='hidden'][name='_method'][value='put']", visible: false }

  #   ユーザ名フィールドのチェック
  it { is_expected.to have_css "form#edit_user_#{user.id} div.form-group.user_name label[for='user_name']", text: "#{I18n.t('simple_form.required.mark')} #{I18n.t('activerecord.attributes.user.name')}" }
  it { is_expected.to have_css "form#edit_user_#{user.id} div.form-group.user_name input#user_name[name='user[name]'][type='text']" }
  it { is_expected.to have_field 'user[name]', with: user.name, id: 'user_name', type: 'text' }

  #   パスワードフィールドのチェック
  it { is_expected.to have_css "form#edit_user_#{user.id} div.form-group.user_password label[for='user_password']", text: I18n.t('activerecord.attributes.user.password') }
  it { is_expected.to have_css "form#edit_user_#{user.id} div.form-group.user_password input#user_password[name='user[password]'][type='password']" }

  #   パスワード確認フィールドのチェック
  it { is_expected.to have_css "form#edit_user_#{user.id} div.form-group.user_password_confirmation label[for='user_password_confirmation']", text: I18n.t('activerecord.attributes.user.password_confirmation') }
  it { is_expected.to have_css "form#edit_user_#{user.id} div.form-group.user_password_confirmation input#user_password_confirmation[name='user[password_confirmation]'][type='password']" }

  #   submitボタンのチェック
  it { is_expected.to have_css "form#edit_user_#{user.id} button#edit_my_submit[name='button'][type='submit']" }
  it { is_expected.to have_button I18n.t('my.edit.submit'), id: 'edit_my_submit' }


  ## bootstrap

  # パンくずリストのチェック
  it { is_expected.to have_css 'nav[aria-label="breadcrumb"]' }
  it { is_expected.to have_css 'nav[aria-label="breadcrumb"] ol.breadcrumb' }
  it { is_expected.to have_css 'nav[aria-label="breadcrumb"] ol.breadcrumb li.breadcrumb-item' }
  it { is_expected.to have_css 'nav[aria-label="breadcrumb"] ol.breadcrumb li.breadcrumb-item a[href="/"]', text: I18n.t('page_name.home') }
  it { is_expected.to_not have_css 'nav[aria-label="breadcrumb"] ol.breadcrumb li.breadcrumb-item.active[aria-current="page"] a' }
  it { is_expected.to have_css 'nav[aria-label="breadcrumb"] ol.breadcrumb li.breadcrumb-item.active[aria-current="page"]', text: I18n.t('page_name.edit_my_account') }

  #   ユーザ名フィールドのチェック
  it { is_expected.to have_css "form#edit_user_#{user.id} div.form-group.user_name label[for='user_name']" }
  it { is_expected.to have_css "form#edit_user_#{user.id} div.form-group.user_name input#user_name", class: 'form-control' }

  #   パスワードフィールドのチェック
  it { is_expected.to have_css "form#edit_user_#{user.id} div.form-group.user_password label[for='user_password']" }
  it { is_expected.to have_css "form#edit_user_#{user.id} div.form-group.user_password input#user_password", class: 'form-control' }

  #   パスワード確認フィールドのチェック
  it { is_expected.to have_css "form#edit_user_#{user.id} div.form-group.user_password_confirmation label[for='user_password_confirmation']" }
  it { is_expected.to have_css "form#edit_user_#{user.id} div.form-group.user_password_confirmation input#user_password_confirmation", class: 'form-control' }

  #   submitボタンのチェック
  it { is_expected.to have_css "form#edit_user_#{user.id} button#edit_my_submit.btn.btn-primary.btn-lg.btn-block" }

end
