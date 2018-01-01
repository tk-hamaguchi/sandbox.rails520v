require 'rails_helper'

RSpec.describe 'layouts/application.html.haml', type: :view do
  subject do
    render template: 'layouts/application'
    rendered
  end
  it { is_expected.to have_xpath '/html/head', visible: false }
  it { is_expected.to have_xpath '/html/head/title', text: 'Rails520v', visible: false }
  it { is_expected.to have_xpath '/html/head/meta[@http-equiv="Content-Type"][@content="text/html; charset=UTF-8"]', visible: false }
  it { is_expected.to have_css 'html head link[rel="stylesheet"][media="all"][data-turbolinks-track="reload"][href^="/assets/application-"]', visible: false }
  it { is_expected.to have_css 'html head script[data-turbolinks-track="reload"][src^="/assets/application-"]', visible: false }
  it { is_expected.to have_xpath '/html/body', visible: false }
end
