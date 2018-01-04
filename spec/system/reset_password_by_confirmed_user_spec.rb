require 'rails_helper'

RSpec.feature 'パスワード再発行機能', type: :system do
  let(:tenant) { FactoryBot.create :tenant }
  let(:user)   { FactoryBot.create :confirmed_user, tenant_id: tenant.id }
  let(:from)   { 'please-change-me-at-config-initializers-devise@example.com' }

  context '登録済ユーザは' do
    scenario 'パスワードを再発行することができる', js: :true do
      # ホームページを表示
      visit root_path

      # ログインリンクをクリック
      find(:css, "nav a[href=\"#{new_user_session_path}\"]").click
      expect(page.current_path).to eq '/users/sign_in'

      # パスワードを忘れましたか?リンクをクリック
      click_link 'パスワードを忘れましたか?'
      expect(page.current_path).to eq '/users/password/new'

      # パスワード再発行要求フォームに入力して送信
      expect(page).to have_css :h2, text: 'パスワードを忘れましたか?'
      expect(page).to have_css 'form#new_user_password'
      within :css, 'form#new_user_password' do
        fill_in 'メールアドレス', with: user.email
        click_button 'パスワードの再設定方法を送信する'
      end

      # メールが送信され、ログインページに戻る
      expect(page.current_path).to eq '/users/sign_in'
      expect(page).to have_css '#information_area', text: 'パスワードの再設定について数分以内にメールでご連絡いたします。'
      expect(ActionMailer::Base.deliveries).to_not be_empty

      mail = ActionMailer::Base.deliveries.last
      expect(mail.from).to include from
      expect(mail.to).to include user.email
      expect(mail.reply_to).to include from
      expect(mail.subject).to eq 'パスワードの再設定について'
      expect(mail.body.raw_source).to match Regexp.escape(
        <<~"EOT"
          <p>#{user.email}様</p>
          <p>パスワード再設定の依頼を受けたため、メールを送信しています。下のリンクからパスワードの再設定ができます。</p>
          <p><a href="http://localhost:3000/users/password/edit?reset_password_token=__RESET_PASSWORD_TOKEN__">パスワード変更</a></p>
          <p>パスワード再設定の依頼をしていない場合、このメールを無視してください。</p>
          <p>パスワードの再設定は、上のリンクから新しいパスワードを登録するまで完了しません。</p>
        EOT
      ).gsub('__RESET_PASSWORD_TOKEN__', '.+')

      reset_password_path = mail.body.raw_source.match(/(\/users\/password\/edit\?reset_password_token=.+)"/)[1]

      ActionMailer::Base.deliveries.clear

      visit reset_password_path
      expect(page.current_path).to eq '/users/password/edit'

      new_password = FactoryBot.generate :password

      # パスワード再発行フォームに入力して送信
      expect(page).to have_css :h2, text: 'パスワードを変更'
      expect(page).to have_css 'form#edit_user_password'
      within :css, 'form#edit_user_password' do
        fill_in '* 新しいパスワード',       with: new_password
        fill_in '* 確認用新しいパスワード', with: new_password
        click_button 'パスワードを変更する'
      end

      # パスワードが変更され、トップページに戻る
      expect(page.current_path).to eq '/my'
      expect(page).to have_css '#information_area', text: 'パスワードが正しく変更されました。'

      # 一旦ログアウト
      click_link user.name
      click_link 'ログアウト'
      expect(page.current_path).to eq '/'
      expect(page).to have_css '#information_area', text: 'ログアウトしました。'

      # ログインリンクをクリック
      find(:css, "nav a[href=\"#{new_user_session_path}\"]").click
      expect(page.current_path).to eq '/users/sign_in'

      # ログインフォームに入力
      within :css, 'form#new_user_session' do
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード',     with: new_password
        click_button 'ログイン'
      end

      expect(page.current_path).to eq '/my'
      expect(page).to have_css :div, text: 'ログインしました。'

    end
  end

end
