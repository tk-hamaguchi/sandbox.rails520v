require 'rails_helper'

RSpec.feature 'ユーザ登録時のメール確認機能', type: :system do
  let(:tenant) { FactoryBot.create :tenant }
  let(:user)   { FactoryBot.create :confirmed_user, tenant_id: tenant.id }
  let(:from)   { 'please-change-me-at-config-initializers-devise@example.com' }

  context 'ユーザが作成されたとき' do
    scenario 'アカウント確認メールを通してサインアップすることができる', js: :true do

      # まずユーザをロックする
      user.lock_access!

      # ユーザのメールアドレス宛に確認メールが送信されている
      expect(ActionMailer::Base.deliveries).to_not be_empty

      mail = ActionMailer::Base.deliveries.last
      expect(mail.from).to include from
      expect(mail.to).to include user.email
      expect(mail.reply_to).to include from
      expect(mail.subject).to eq 'アカウントの凍結解除について'
      expect(mail.body.raw_source).to match Regexp.escape(
        <<~"EOT"
          <p>#{user.email}様</p>
          <p>ログイン失敗が繰り返されたため、アカウントはロックされています。</p>
          <p>アカウントのロックを解除するには下のリンクをクリックしてください。</p>
          <p><a href="http://localhost:3000/users/unlock?unlock_token=__UNLOCK_TOKEN__">アカウントのロック解除</a></p>
        EOT
      ).gsub('__UNLOCK_TOKEN__', '.+')

      unlock_user_path = mail.body.raw_source.match(/(\/users\/unlock\?unlock_token=.+)"/)[1]

      ActionMailer::Base.deliveries.clear

      # メールに含まれているアカウント確認リンクを開くとログインページが表示される
      visit unlock_user_path
      expect(page).to have_css '#information_area', text: 'アカウントを凍結解除しました。'
      expect(page.current_path).to eq '/users/sign_in'

      # ログインフォームに登録の際に入力した情報を入力してログイン
      within :css, 'form#new_user_session' do
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード',     with: user.password
        click_button 'ログイン'
      end

      expect(page.current_path).to eq '/'
      expect(page).to have_css :h1, text: 'Home#index'
      expect(page).to have_css '#information_area', text: 'ログインしました。'

    end
  end

end
