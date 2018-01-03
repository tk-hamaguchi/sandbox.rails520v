require 'rails_helper'

RSpec.describe 'layouts/_footer.html.haml', type: :view do
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
  before {
    travel_to Time.zone.parse('2017-12-01T13:03:23.123+09:00')
    stub_template 'layouts/application.html.haml' => layout
    render
  }

  after { travel_back }
  it { expect(rendered).to have_xpath '//body/div[@id="footer"]' }
  it { expect(rendered).to have_xpath '//body/div[@id="footer"]/div[@class="version_no"]', text: "Ver.\n#{Rails520v::VERSION}" }
  it { expect(rendered).to have_xpath '//body/div[@id="footer"]/address[@class="copylight"]', text: 'Copyright © 2017 @tk_hamaguchi' }

end
