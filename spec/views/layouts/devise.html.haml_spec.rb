require 'rails_helper'

RSpec.describe 'layouts/devise.html.haml', type: :view do
  let(:center_middle_layout) {
    <<~"EOT"
      !!!
      %html
        %head
          %title
            CENTER_MIDDLE_LAYOUT
          = yield :stylesheet_links
          = yield :javascript_links
        %body
          = content_for?(:application_content) ? yield(:application_content) : yield
    EOT
  }
  before {
    stub_template 'layouts/center_middle.html.haml' => center_middle_layout
    render
  }

  it { expect(rendered).to have_title 'CENTER_MIDDLE_LAYOUT' }

end
