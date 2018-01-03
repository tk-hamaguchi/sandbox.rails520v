require 'rails_helper'

RSpec.describe 'layouts/_header.html.haml', type: :view do
  let(:layout) {
    <<~"EOT"
      !!!
      %html
        %head
          = yield :stylesheet_links
          = yield :javascript_links
        %body
          = content_for?(:application_content) ? yield(:application_content) : yield
    EOT
  }
  let(:user_signed_in) { false }
  before {
    travel_to Time.zone.parse('2017-12-01T13:03:23.123+09:00')
    stub_template 'layouts/application.html.haml' => layout
    allow(view).to receive(:user_signed_in?).and_return(user_signed_in)
    allow(view).to receive(:current_user).and_return(double(User, name: 'HOGE'))
    render
  }
  subject { render; rendered }
  after { travel_back }

  it { is_expected.to have_css 'body header' }
  it { is_expected.to have_link I18n.t('app_name'), href: root_path }

  # bootstrap
  it { is_expected.to have_css 'header nav.navbar.navbar-expand.navbar-light.bg-light' }
  it { is_expected.to have_css 'header nav.navbar a.navbar-brand[href="/"]', text: I18n.t('app_name') }

  context 'access by unknown user' do
    let(:user_signed_in) { false }
    it { is_expected.to have_link I18n.t('sign_in'), href: new_user_session_path }
    it { is_expected.to_not have_link I18n.t('sign_out'), href: destroy_user_session_path }

    # bootstrap
    it { is_expected.to have_css 'header nav a.btn.btn-outline-secondary.btn-sm.ml-auto[href="' + new_user_session_path + '"]' }
  end

  context 'access by logined user' do
    let(:user_signed_in) { true }
    it { is_expected.to_not have_link I18n.t('sign_in'), href: new_user_session_path }
    it { is_expected.to have_link I18n.t('sign_out'), href: destroy_user_session_path }

    # bootstrap
    it { is_expected.to have_css 'header nav ul.navbar-nav' }
    it { is_expected.to have_css 'header nav ul.navbar-nav li.nav-item.dropdown a#navbarDropdown.nav-item.nav-link.dropdown-toggle span.d-none.d-sm-inline', text: 'HOGE' }
    it { is_expected.to have_css 'header nav ul.navbar-nav li.nav-item.dropdown div.dropdown-menu.dropdown-menu-right' }
    it { is_expected.to have_css 'header nav ul.navbar-nav li.nav-item.dropdown div.dropdown-menu.dropdown-menu-right a.dropdown-item[href="' + destroy_user_session_path + '"]', text: I18n.t('sign_out') }

  end
end
