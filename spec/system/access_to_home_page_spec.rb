require 'rails_helper'

RSpec.feature 'ホームページへのアクセス', type: :system do

  context 'ホームページにアクセスしたとき、' do
    scenario 'ホームページが表示される', js: :true do
      visit root_path
      expect(page.current_path).to eq '/'
      expect(page).to have_css :h1, text: 'Home#index'
    end
  end

end
