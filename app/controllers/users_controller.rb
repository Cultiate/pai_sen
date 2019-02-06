class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    @user = current_user
    @invitation = Invitation.find_by(user_id: params[:user_id])
  end

  def create
    @user = User.new(user_params)
      if @user.save
        @user.send_activation_email
        redirect_to root_url
        flash[:success] = "登録メールアドレスに本登録のURLを送信しました。"
      end
  end

  private

    def user_params
      params.require(:user).permit(
        :name, :kana, :email, :birthday, :university, :department, :graduate_year, :greeting,
        :password, :password_confirmation, :remember_digest, :activation_digest, :activated, :activated_at,
        :user_image, :provider, :uid, :reset_digest, :reset_sent_at
      )
    end

    def correct_user
      @user = User.find_by(id: params[:id])
      redirect_to root_url unless current_user?(@user)
    end
end
