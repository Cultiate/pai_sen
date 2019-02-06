class PasswordResetsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "パスワード再設定のメールをお送りしました。"
      redirect_to root_url
    else
      flash.now[:danger] = "メールアドレスが見つかりません。"
      render "new"
    end
  end

  def edit
    @user = User.find_by(email: params[:email])
  end

  def update
    @user = User.find_by(email: params[:email])
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render "new"
    elsif @user.update_attributes(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = "パスワードは更新されました。"
      redirect_to root_url(:user_id, @user.id)
    else
      render template "root/top"
    end
  end


  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end
