require 'rails_helper'

RSpec.feature 'ログイン機能', type: :system do
  let(:tenant) { FactoryBot.create :tenant }
  let(:user)   { FactoryBot.create :confirmed_user, tenant_id: tenant.id }

  context '登録済ユーザは' do
    scenario 'ログインページからログインすることができる', js: :true do
      # ホームページを表示
      visit root_path

      # ログインリンクをクリック
      find(:css, "a[href=\"#{new_user_session_path}\"]").click

      # ログインフォームに入力
      within(:css, "form[action=\"#{user_session_path}\"][method=\"post\"]") do
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード',     with: user.password
        click_button 'ログイン'
      end

      expect(page.current_path).to eq '/'
      expect(page).to have_css :h1, text: 'Home#index'
      expect(page).to have_css :div, text: 'ログインしました。'

    end
  end

end
