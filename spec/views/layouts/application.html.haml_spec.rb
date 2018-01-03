require 'rails_helper'

RSpec.describe 'layouts/application.html.haml', type: :view do
  let(:locals) { {} }
  before do
    stub_template 'layouts/_header.html.haml' => 'HEADER_CONTENTS'
  end
  subject do
    render template: 'layouts/application', locals: locals
    rendered
  end
  it { is_expected.to have_xpath '/html/head', visible: false }
  it { is_expected.to have_xpath '/html/head/title', text: I18n.t('app_name'), visible: false }
  it { is_expected.to have_xpath '/html/head/meta[@http-equiv="Content-Type"][@content="text/html; charset=UTF-8"]', visible: false }
  it { is_expected.to have_css 'html head link[rel="stylesheet"][media="all"][data-turbolinks-track="reload"][href^="/assets/application-"]', visible: false }
  it { is_expected.to have_css 'html head script[data-turbolinks-track="reload"][src^="/assets/application-"]', visible: false }
  it { is_expected.to have_css 'html head link[rel="stylesheet"][media="screen"][href^="/packs-test/application-"]', visible: false }
  it { is_expected.to have_css 'html head script[src^="/packs-test/application-"]', visible: false }
  it { is_expected.to have_xpath '/html/head/meta[@http-equiv="x-ua-compatible"][@content="ie=edge"]', visible: false }
  it { is_expected.to have_xpath '/html/head/meta[@name="viewport"][@content="width=device-width, initial-scale=1, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no, shrink-to-fit=no"]', visible: false }
  it { is_expected.to have_xpath '/html/body', visible: false }

  context 'with locals' do
    context '{ header: false }' do
      let(:locals) { { header: false } }
      it { is_expected.to_not have_xpath '/html/body', text: 'HEADER_CONTENTS' }
    end

    context '{ header: true }' do
      let(:locals) { { header: true } }
      it { is_expected.to have_xpath '/html/body', text: 'HEADER_CONTENTS' }
    end
  end
end
