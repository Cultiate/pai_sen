class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    @user = current_user
  end

  def detail
    @user = current_user
  end

  def create
    @user = User.new(user_params)
      if @user.save
        @user.send_activation_email
        flash[:success] = "登録メールアドレスに本登録のURLを送信しました。"
        redirect_to root_url
      end
  end

  def detail_update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    if @user.save
      flash[:success] = "登録が完了しました。"
      redirect_to @user
    else
      render "detail"
    end
  end

  def password_update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    if @user.save
      flash[:success] = "登録が完了しました。"
      redirect_to @user
    else
      render "detail"
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
