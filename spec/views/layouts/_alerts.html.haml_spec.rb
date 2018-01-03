require 'rails_helper'

RSpec.describe 'layouts/_alerts.html.haml', type: :view do
  before { render }
  it { expect(rendered).to be_empty }

  context 'with flash[:notice]' do
    before {
      flash[:notice] = 'FLASH_NOTICE_MESSAGE'
      render
    }
    it { expect(rendered).to have_xpath '//div[@id="information_area"][@class="alert alert-info"]', text: 'FLASH_NOTICE_MESSAGE' }
  end

  context 'with flash[:alert]' do
    before {
      flash[:alert] = 'FLASH_ALERT_MESSAGE'
      render
    }
    it { expect(rendered).to have_xpath '//div[@id="warning_area"][@class="alert alert-danger"]', text: 'FLASH_ALERT_MESSAGE' }
  end

end
