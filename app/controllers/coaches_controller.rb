class UsersController < ApplicationController

  def new
    @coach = User.new
  end

  def show
    @coach = current_user
  end

  def detail
    @coach = current_user
  end

  def create
    @coach = User.new(user_params)
      if @coach.save
        @coach.send_activation_email
        flash[:success] = "登録メールアドレスに本登録のURLを送信しました。"
        redirect_to root_url
      end
  end

  def detail_update
    @coach = User.find(params[:id])
    @coach.update_attributes(user_params)
    if @coach.save
      flash[:success] = "登録が完了しました。"
      redirect_to @coach
    else
      render "detail"
    end
  end

  def password_update
    @coach = User.find(params[:id])
    @coach.update_attributes(user_params)
    if @coach.save
      flash[:success] = "登録が完了しました。"
      redirect_to @coach
    else
      render "detail"
    end
  end

  private

    def coach_params
      params.require(:coach).permit(
        :name, :kana, :email, :birthday, :university, :department, :graduate_year, :greeting,
        :password, :password_confirmation, :remember_digest, :activation_digest, :activated, :activated_at,
        :user_image, :provider, :uid, :reset_digest, :reset_sent_at
      )
    end

    def correct_coach
      @coach = User.find_by(id: params[:id])
      redirect_to root_url unless current_user?(@coach)
    end
end
