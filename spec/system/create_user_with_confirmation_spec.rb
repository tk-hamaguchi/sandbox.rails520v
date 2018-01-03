require 'rails_helper'

RSpec.feature 'ユーザ登録時のメール確認機能', type: :system do
  let(:tenant) { FactoryBot.create :tenant }
  let(:from)   { 'please-change-me-at-config-initializers-devise@example.com' }

  context 'ユーザが作成されたとき' do
    scenario 'アカウント確認メールを通してサインアップすることができる', js: :true do

      # まずユーザを作る
      user = FactoryBot.create :user, tenant_id: tenant.id

      # ユーザのメールアドレス宛に確認メールが送信されている
      expect(ActionMailer::Base.deliveries).to_not be_empty

      mail = ActionMailer::Base.deliveries.last
      expect(mail.from).to include from
      expect(mail.to).to include user.email
      expect(mail.reply_to).to include from
      expect(mail.subject).to eq 'アカウントの有効化について'
      expect(mail.body.raw_source).to match Regexp.escape(
        <<~"EOT"
          <p>
          #{user.email}様
          </p>
          <p>次のリンクでメールアドレスの確認が完了します。</p>
          <p><a href="http://localhost:3000/users/confirmation?confirmation_token=__CONFIRMATION_TOKEN__">アカウント確認</a></p>
        EOT
      ).gsub('__CONFIRMATION_TOKEN__', '.+')

      confirmation_user_path = mail.body.raw_source.match(/(\/users\/confirmation\?confirmation_token=.+)"/)[1]

      ActionMailer::Base.deliveries.clear

      # メールに含まれているアカウント確認リンクを開くとログインページが表示される
      visit confirmation_user_path
      expect(page).to have_css '#information_area', text: 'アカウントを登録しました。'
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
