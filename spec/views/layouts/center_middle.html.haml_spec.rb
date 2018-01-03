require 'rails_helper'

RSpec.describe 'layouts/center_middle.html.haml', type: :view do
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
  before do
    stub_template 'layouts/application.html.haml' => application_layout
    stub_template 'layouts/_footer.html.haml'     => footer_contents
  end
  subject { render; rendered }

  it { is_expected.to have_xpath '//body/div[@class="center-middle-layout"]' }
  it { is_expected.to have_xpath '//body/div[@class="center-middle-layout"]/div[@class="center-middle-layout-wrapper"]' }
  it { is_expected.to have_xpath '//body/div[@class="center-middle-layout"]/div[@class="center-middle-layout-wrapper"]/div[@class="container"]' }
  it { is_expected.to have_xpath '//body/div[@class="center-middle-layout"]/div[@class="center-middle-layout-wrapper"]/div[@class="center-middle-layout-footer"]' }
  it { is_expected.to have_xpath '//body/div[@class="center-middle-layout"]/div[@class="center-middle-layout-wrapper"]/div[@class="center-middle-layout-footer"]', text: footer_contents }

  it { is_expected.to have_css 'link[rel="stylesheet"][media="screen"][href^="/packs-test/center_middle_layout-"]', visible: false }

  it { is_expected.to have_title 'APPLICATION_LAYOUT' }
end
