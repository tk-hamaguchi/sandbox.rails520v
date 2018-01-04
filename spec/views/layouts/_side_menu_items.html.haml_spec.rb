require 'rails_helper'

RSpec.describe 'layouts/_side_menu_items.html.haml', type: :view do
  let(:current_path) { '/' }
  before { allow(view).to receive(:request).and_return(double(String, path: current_path)) }
  subject { render; rendered }
  it { is_expected.to have_link I18n.t('layouts.side_menu_items.home'), href: my_path }

  # bootstrap
  it { is_expected.to have_css 'a.nav-link[href="/my"]', text: I18n.t('layouts.side_menu_items.home') }
  it { is_expected.to_not have_css 'a.nav-link.active[href="/my"]', text: I18n.t('layouts.side_menu_items.home') }

  context 'embedded from' do
    context '/my' do
      let(:current_path) { '/my' }
      it { is_expected.to have_css 'a.nav-link.active[href="/my"]', text: I18n.t('layouts.side_menu_items.home') }
    end
  end
end
