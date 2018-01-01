require 'rails_helper'

RSpec.describe 'home/index.html.haml', type: :view do
  subject { render ; rendered }
  it { is_expected.to have_css :h1, text: 'Home#index' }
end
