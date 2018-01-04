require 'rails_helper'

RSpec.describe 'layouts/my.html.haml', type: :view do
  let(:grid_system_layout) {
    <<~"EOT"
      !!!
      %html
        %head
          %title
            GRID_SYSTEM_LAYOUT
          = yield :stylesheet_links
          = yield :javascript_links
        %body
          = content_for?(:application_content) ? yield(:application_content) : yield
    EOT
  }
  before do
    stub_template 'layouts/grid_system.html.haml' => grid_system_layout
  end
  subject { render; rendered }

  it { is_expected.to have_title 'GRID_SYSTEM_LAYOUT' }

  it { is_expected.to have_css 'head link[rel="stylesheet"][media="screen"][href^="/packs-test/my-"]', visible: false }
  it { is_expected.to have_css 'head script[src^="/packs-test/my-"]', visible: false }


end
