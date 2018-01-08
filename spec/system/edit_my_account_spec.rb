require 'rails_helper'

RSpec.feature 'アカウント情報変更機能', type: :system do
  let(:tenant) { FactoryBot.create :tenant }
  let(:user)   { FactoryBot.create :confirmed_user, tenant_id: tenant.id }

  context '登録済ユーザは' do
    context 'アカウント設定ページから' do

      scenario 'アカウント情報を変更することができる', js: :true do
        # ホームページを表示
        visit root_path

        # ログインリンクをクリック
        find(:css, "nav a[href=\"#{new_user_session_path}\"]").click

        # ログインフォームに入力
        within(:css, "form[action=\"#{user_session_path}\"][method=\"post\"]") do
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード',     with: user.password
          click_button 'ログイン'
        end

        expect(page.current_path).to eq '/my'
        expect(page).to have_css :div, text: 'ログインしました。'

        # ドロップダウンからアカウント設定リンクをクリック
        click_link user.name
        click_link 'アカウント設定'

        expect(page.current_path).to eq '/my/edit'

        # アカウント設定ページのアカウント設定フォームに入力
        within(:css, "form#edit_user_#{user.id}") do
          fill_in 'ユーザ名', with: 'ほげ'
          fill_in 'パスワード',           with: 'psWd123'
          fill_in 'パスワード（確認用）', with: 'psWd123'
          click_button 'アカウント設定を更新'
        end

        expect(page.current_path).to eq '/users/sign_in'
        expect(page).to have_css :div, text: 'アカウント登録もしくはログインしてください。'

        # 新しいパスワードでログインしてみる
        within(:css, "form[action=\"#{user_session_path}\"][method=\"post\"]") do
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード',     with: 'psWd123'
          click_button 'ログイン'
        end

        # アカウント設定フォームに含まれているユーザ名が更新されている
        expect(page).to have_css :div, text: 'ログインしました。'
        expect(page).to have_link 'ほげ'
        within(:css, "form#edit_user_#{user.id}") do
          expect(page).to have_field 'user[name]', with: 'ほげ', id: 'user_name'
        end
      end


      scenario 'ユーザ名のみを変更することができる', js: :true do
        # ホームページを表示
        visit root_path

        # ログインリンクをクリック
        find(:css, "nav a[href=\"#{new_user_session_path}\"]").click

        # ログインフォームに入力
        within(:css, "form[action=\"#{user_session_path}\"][method=\"post\"]") do
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード',     with: user.password
          click_button 'ログイン'
        end

        expect(page.current_path).to eq '/my'
        expect(page).to have_css :div, text: 'ログインしました。'

        # ドロップダウンからアカウント設定リンクをクリック
        click_link user.name
        click_link 'アカウント設定'

        expect(page.current_path).to eq '/my/edit'

        # アカウント設定ページのアカウント設定フォームに入力
        within(:css, "form#edit_user_#{user.id}") do
          fill_in 'ユーザ名', with: 'ほげ'
          click_button 'アカウント設定を更新'
        end

        expect(page.current_path).to eq '/my/edit'
        expect(page).to have_css :div, text: 'アカウント情報を変更しました。'
        expect(page).to have_link 'ほげ'
        within(:css, "form#edit_user_#{user.id}") do
          expect(page).to have_field 'user[name]', with: 'ほげ', id: 'user_name'
        end
      end

      scenario 'パスワードを変更することができる', js: true do
        # ホームページを表示
        visit root_path

        # ログインリンクをクリック
        find(:css, "nav a[href=\"#{new_user_session_path}\"]").click

        # ログインフォームに入力
        within(:css, "form[action=\"#{user_session_path}\"][method=\"post\"]") do
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード',     with: user.password
          click_button 'ログイン'
        end

        expect(page.current_path).to eq '/my'
        expect(page).to have_css :div, text: 'ログインしました。'

        # ドロップダウンからアカウント設定リンクをクリック
        click_link user.name
        click_link 'アカウント設定'

        expect(page.current_path).to eq '/my/edit'

        # アカウント設定ページのアカウント設定フォームに入力
        within(:css, "form#edit_user_#{user.id}") do
          fill_in 'パスワード',           with: 'psWd123'
          fill_in 'パスワード（確認用）', with: 'psWd123'
          click_button 'アカウント設定を更新'
        end

        expect(page.current_path).to eq '/users/sign_in'
        expect(page).to have_css :div, text: 'アカウント登録もしくはログインしてください。'

        # ログインフォームに入力
        within(:css, "form[action=\"#{user_session_path}\"][method=\"post\"]") do
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード',     with: 'psWd123'
          click_button 'ログイン'
        end

        # アカウント設定フォームに含まれているユーザ名が元のままである
        expect(page.current_path).to eq '/my/edit'
        expect(page).to have_css :div, text: 'ログインしました。'
        within(:css, "form#edit_user_#{user.id}") do
          expect(page).to have_field 'user[name]', with: user.name, id: 'user_name'
        end
      end

    end
  end

end
