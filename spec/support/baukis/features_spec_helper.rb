module FeaturesSpecHelper
  def login_as_staff_member(staff_memeber, password = 'pw')
    visit baukis_staff_login_path
    within('#login-form') do
      fill_in 'メールアドレス', with: staff_memeber.email
      fill_in 'パスワード', with: password
      click_button 'ログイン'
    end
  end
end