class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:user_id])
  end

  def detail
    @user = User.find(params[:user_id])
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
    @user = User.find(params[:user_id])
    @user.update_attributes(user_params)
    if @user.save
      flash[:success] = "登録が完了しました。"
      redirect_to @user
    else
      render "detail"
    end
  end

  def password_update
    @user = User.find(params[:user_id])
    @user.update_attributes(user_params)
    if @user.save
      flash[:success] = "登録が完了しました。"
      redirect_to @user
    else
      render "detail"
    end
  end

  def message_show
    @room_id = message_room_id(current_user, @user)
    @messages = Message.recent_in_room(@room_id)
  end

  def message_room_id(first_user, second_user)
    first_id = first_user.id.to_i
    second_id = second_user.id.to_i
    if first_id < second_id
      "#{first_user.id}-#{second_user.id}"
    else
      "#{second_user.id}-#{first_user.id}"
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
      @user = User.find_by(id: params[:user_id])
      redirect_to root_url unless current_user?(@user)
    end
end
