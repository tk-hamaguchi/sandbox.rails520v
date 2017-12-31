require 'rails_helper'

RSpec.feature 'ホームページへのアクセス', type: :system do

  context 'ホームページにアクセスしたとき、' do
    scenario 'ホームページが表示される', js: :true do
      visit root_path
      expect(page.current_path).to eq '/'
    end
  end

end
