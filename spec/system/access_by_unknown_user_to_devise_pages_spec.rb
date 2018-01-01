require 'rails_helper'

RSpec.feature '不明なユーザーによるdeviseページへの直接アクセス', type: :system do

  context '不明なユーザーが' do
    context 'ログインページにアクセスしたとき、' do
      scenario 'ログインページが表示される', js: :true do
        visit new_user_session_path
        expect(page).to have_current_path '/users/sign_in'
      end
    end

    context 'パスワード再発行要求ページにアクセスしたとき、' do
      scenario 'パスワード再発行要求ページが表示される', js: :true do
        visit new_user_password_path
        expect(page).to have_current_path '/users/password/new'
      end
    end

    context 'パスワード再発行ページにアクセスしたとき、' do
      scenario 'ログインページが表示される', js: :true do
        visit edit_user_password_path
        expect(page).to have_current_path '/users/sign_in'
      end
    end

    context 'アカウント確認要求ページにアクセスしたとき、' do
      scenario 'アカウント確認要求ページが表示される', js: :true do
        visit new_user_confirmation_path
        expect(page).to have_current_path '/users/confirmation/new'
      end
    end

    context 'アカウント確認ページにアクセスしたとき、' do
      scenario 'アカウント確認ページが表示される', js: :true do
        visit user_confirmation_path
        expect(page).to have_current_path '/users/confirmation'
      end
    end

    context 'アカウントロック解除要求ページにアクセスしたとき、' do
      scenario 'アカウントロック解除要求ページが表示される', js: :true do
        visit new_user_unlock_path
        expect(page).to have_current_path '/users/unlock/new'
      end
    end

    context 'アカウントロック解除ページにアクセスしたとき、' do
      scenario 'アカウントロック解除ページが表示される', js: :true do
        visit user_unlock_path
        expect(page).to have_current_path '/users/unlock'
      end
    end

  end
end
