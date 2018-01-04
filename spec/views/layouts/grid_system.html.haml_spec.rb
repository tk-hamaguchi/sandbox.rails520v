require 'rails_helper'

RSpec.describe 'layouts/grid_system.html.haml', type: :view do
  let(:application_layout) {
    <<~"EOT"
      !!!
      %html
        %head
          %title
            APPLICATION_LAYOUT
          = yield :stylesheet_links
          = yield :javascript_links
        %body
          = content_for?(:application_content) ? yield(:application_content) : yield
    EOT
  }
  let(:footer_contents) {
    'FOOTER_CONTENTS'
  }
  let(:locals) { {} }
  before do
    stub_template 'layouts/application.html.haml' => application_layout
    stub_template 'layouts/_footer.html.haml'     => footer_contents
    stub_template 'layouts/_side_menu_items.html.haml' => 'SIDE_MENU_ITEMS'
  end
  subject do
    render template: 'layouts/grid_system.html.haml', locals: locals
    rendered
  end


  it { is_expected.to have_css 'head link[rel="stylesheet"][media="screen"][href^="/packs-test/grid_system_layout-"]', visible: false }

  it { is_expected.to have_xpath '//body/div[@class="container-fluid"]' }
  it { is_expected.to have_xpath '//body/div[@class="container-fluid"]/div[@class="row"]' }
  it { is_expected.to have_xpath '//body/div[@class="container-fluid"]/div[@class="row"]/div[@class="col-sm-9"]' }
  it { is_expected.to have_xpath '//body/div[@class="container-fluid"]/div[@class="row"]/div[@class="col-sm-9"]/main[@id="main_contents"]' }
  it { is_expected.to have_xpath '//body/div[@class="container-fluid"]/div[@class="row"]/div[@class="col-sm-9"]/footer[@class="clearfix"]' }
  it { is_expected.to have_xpath '//body/div[@class="container-fluid"]/div[@class="row"]/div[@class="col-sm-9"]/footer[@class="clearfix"]/div[@class="container-fluid"]' }
  it { is_expected.to have_xpath '//body/div[@class="container-fluid"]/div[@class="row"]/div[@class="col-sm-9"]/footer[@class="clearfix"]/div[@class="container-fluid"]/div[@class="row"]/div[@class="col-sm-12"]' }
  it { is_expected.to have_xpath '//body/div[@class="container-fluid"]/div[@class="row"]/div[@class="col-sm-9"]/footer[@class="clearfix"]/div[@class="container-fluid"]/div[@class="row"]/div[@class="col-sm-12"]', text: footer_contents }

  it { is_expected.to have_xpath '//body/div[@class="container-fluid"]/div[@class="row"]/nav[@class="col-sm-3 order-first"][@id="side_menu"]' }
  it { is_expected.to have_xpath '//body/div[@class="container-fluid"]/div[@class="row"]/nav[@class="col-sm-3 order-first"][@id="side_menu"]', text: 'SIDE_MENU_ITEMS' }

  it { is_expected.to have_css 'head script[src^="/packs-test/grid_system_layout-"]', visible: false }

  context 'with locals' do
    context '{ side_menu: false }' do
      let(:locals) { { side_menu: false } }
      it { is_expected.to have_xpath '//body/div[@class="container-fluid"]/div[@class="row"]/div[@class="col-sm-12"]' }
      it { is_expected.to have_xpath '//body/div[@class="container-fluid"]/div[@class="row"]/div[@class="col-sm-12"]/main[@id="main_contents"]' }
      it { is_expected.to have_xpath '//body/div[@class="container-fluid"]/div[@class="row"]/div[@class="col-sm-12"]/footer[@class="clearfix"]' }
      it { is_expected.to have_xpath '//body/div[@class="container-fluid"]/div[@class="row"]/div[@class="col-sm-12"]/footer[@class="clearfix"]/div[@class="container-fluid"]' }
      it { is_expected.to have_xpath '//body/div[@class="container-fluid"]/div[@class="row"]/div[@class="col-sm-12"]/footer[@class="clearfix"]/div[@class="container-fluid"]/div[@class="row"]/div[@class="col-sm-12"]' }
      it { is_expected.to have_xpath '//body/div[@class="container-fluid"]/div[@class="row"]/div[@class="col-sm-12"]/footer[@class="clearfix"]/div[@class="container-fluid"]/div[@class="row"]/div[@class="col-sm-12"]', text: footer_contents }
      it { is_expected.to_not have_xpath '//body/div[@class="container-fluid"]/div[@class="row"]/nav[@id="side_menu"]' }
    end
  end

end
