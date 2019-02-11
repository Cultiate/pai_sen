class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "メールアドレスの認証について"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "パスワードの再設定について"
  end
end
