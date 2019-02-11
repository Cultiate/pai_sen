class CoachMailer < ApplicationMailer

  def account_activation(coach)
    @coach = coach
    mail to: coach.email, subject: "メールアドレスの認証について"
  end

  def password_reset(coach)
    @coach = coach
    mail to: coach.email, subject: "パスワードの再設定について"
  end
end
